module InterfaceLift
  class Catalog
    attr_reader :catalog_path
    
    def initialize(catalog_path = nil)
      @catalog_path = catalog_path.nil? ? DEFAULT_CATELOG_PATH : catalog_path
    end
    
    # Retrieve themes from specified catalog path
    def themes
      themes = []
      Dir.glob("#{@catalog_path}/*").each do |item|
        themes << item if File.directory? item
      end
      themes.map { |path| path.split("/").last }
    end
  end
end