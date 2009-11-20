require 'rubygems'
require 'git'
   
module InterfaceLift
  
  # Catalogs manage themes
  class Catalog
    attr_reader :catalog_path
    
    # Construct catalog
    def initialize(catalog_path = nil)
      @catalog_path = catalog_path.nil? ? ::InterfaceLift::DEFAULT_CATALOG_PATH : catalog_path
      create_catalog_path!
    end
    
    # Retrieve themes from specified catalog path
    def themes
      themes = []
      Dir.glob("#{@catalog_path}/*").each do |item|
        theme = item.split("/").last
        themes << theme if git_repo?(theme)
      end
      return themes
    end
    
    # Does the given theme exist in the working path
    def theme_exists?(theme)
      return themes.include?(theme)
    end
    
    # Is the argumented theme a git repository?
    def git_repo?(theme)
      begin
        g = Git.open("#{catalog_path}/#{theme}")        
      rescue ArgumentError => e
        # If the path does not exist it will return an ArgumentError        
        return false
      end       
      return g.index.readable?
    end
    
    # Retrieve the latest version of argumented theme from git repository
    def update_theme(theme)
      return false unless git_repo?(theme)
      g = Git.open("#{catalog_path}/#{theme}")
      return ! g.pull.match(/^Updating/).nil?
    end
    
    # Remove theme from catalog
    def remove_theme(theme)
      FileUtils.rm_rf("#{@catalog_path}/#{theme}") 
    end
    
    # Download a theme from git repository
    def add_theme(theme, repo)
      remove_theme(theme)
      return ! Git.clone(repo, "#{@catalog_path}/#{theme}").repo.path.nil?
    end
    
    # Create catalog path when it does not exist
    def create_catalog_path!
       FileUtils.mkdir_p(@catalog_path) unless File.exists?(@catalog_path)
    end

  end
end