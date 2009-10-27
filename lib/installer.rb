module InterfaceLift
  class Installer
      attr_reader :path, :theme, :theme_path
      APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
      SHARED = "#{APP_ROOT}/lib/templates/shared"
  
  
      def initialize(path,theme)      
        @path = path
        @theme = theme 
        @theme_path =  "#{APP_ROOT}/lib/templates/#{theme}"      

        raise "Given path does not contain a rails app." unless File.directory? "#{@path}/public" 
        raise "Theme #{@theme} is not available." unless File.directory? @theme_path   
      end
     
      def install!  
        install_images
        install_stylesheets
        install_layouts
        install_javascript
        install_shared
      end
      
      private
      def install_images
        FileUtils.cp_r "#{@theme_path}/public/images","#{path}/public"  if File.directory? "#{@theme_path}/public/images"
      end
  
      def install_stylesheets
        FileUtils.cp_r "#{@theme_path}/public/stylesheets","#{path}/public"  if File.directory?  "#{@theme_path}/public/stylesheets"                 
      end
  
      def install_layouts
        FileUtils.cp_r "#{@theme_path}/app/views/layouts","#{path}/app/views"  if File.directory?  "#{@theme_path}/views/layouts"                 
      end
  
      def install_javascript
        FileUtils.cp_r "#{@theme_path}/public/javascripts","#{path}/public"  if File.directory?  "#{@theme_path}/public/javascripts"                 
      end
  
      def install_shared
        FileUtils.cp_r "#{SHARED}/icons","#{path}/public/images/"  if File.directory?  "#{@theme_path}/icons"                        
      end       
  end   
end  
