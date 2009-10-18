module  InterfaceLift  
  class Installer
    attr_reader :path, :theme, :theme_path
    APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
    SHARED = "#{APP_ROOT}/lib/templates/shared"
    
    
    def initialize(path,theme)      
      @path = path
      @theme = theme
      raise "Not a rails app" unless File.directory? "#{path}/public" 
      @theme_path =  "#{APP_ROOT}/lib/templates/#{theme}"      
      raise "Theme #{theme} not found" unless File.directory? theme_path   
    end
    
    def install!  
      install_images
      install_stylesheets
      install_layouts
      install_javascript
      install_shared
    end
    
    def install_images
      FileUtils.cp_r "#{@theme_path}/images","#{path}/public"    
    end
    
    def install_stylesheets
      FileUtils.cp_r "#{@theme_path}/stylesheets","#{path}/public"    
    end
    
    def install_layouts
      FileUtils.cp_r "#{@theme_path}/layouts","#{path}/app/views"    
    end
    
    def install_javascript
      FileUtils.cp_r "#{@theme_path}/javascripts","#{path}/public"    
    end
    
    def install_shared
      FileUtils.cp_r "#{SHARED}/icons","#{path}/public/images/"          
    end
    
  end
end