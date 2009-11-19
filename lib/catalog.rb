require 'rubygems'
require 'git'
   
module InterfaceLift
  class Catalog
    DEFAULT_CATELOG_PATH =  "~/.interfacelift"
    attr_reader :catalog_path
    
    def initialize(catalog_path = nil)
      @catalog_path = catalog_path.nil? ? DEFAULT_CATELOG_PATH : catalog_path
      create_catalog_path!
    end
    
    # Retrieve themes from specified catalog path
    def themes
      themes = []
      Dir.glob("#{@catalog_path}/*").each do |item|
        themes << item if File.directory? item
      end
      themes.map { |path| path.split("/").last }
    end
    
    # Does the given theme exist in the working path
    def theme_exists?(theme)
      themes.include?(theme)
    end
    
    # Is the argumented theme a git repository?
    def git_repo?(theme)      
      begin
        g = Git.open("#{catalog_path}/#{theme}")        
      rescue ArgumentError => e
        # If the path does not exist it will return an ArgumentError        
        return false
      end
      !g.repo.path.nil?
    end
    
    # Retrieve the latest version of argumented theme from git repository
    def update_theme(theme)
      return false unless git_repo?(theme)
      g = Git.open("#{catalog_path}/#{theme}")
      !g.pull.match(/^Updating/).nil?
    end
    
    # Remove theme from catalog
    def remove_theme(theme)
      return false unless theme_exists?(theme)
      FileUtils.rm_rf("#{@catalog_path}/#{theme}") 
    end
    
    # Download a theme from git repository
    # returns true when sucessfull
    # raises exception when it fails
    def add_theme(theme, repo)
      remove_theme(theme) if theme_exists?(theme)
      !Git.clone(repo, "#{@catalog_path}/#{theme}").repo.path.nil?
    end
    
    #create catalog path when it does not exist
    def create_catalog_path!
       FileUtils.mkdir_p(@catalog_path) unless File.exists?(@catalog_path)
    end

  end
end


# test = InterfaceLift::Catalog.new
# test.add_theme "bright_admin", "git://github.com/michel/bright_admin.git"
