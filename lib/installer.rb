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
        return  nil unless File.directory? "#{@theme_path}/public/images"      
        File.gob("#{@theme_path}/public/images/*").each do |file|
          puts "Installing #{@theme}/public/images/#{file}"
        end  
        FileUtils.cp_r "#{@theme_path}/public/images","#{path}/public" 
      end
  
      def install_stylesheets 
        return  nil unless File.directory? "#{@theme_path}/public/images"      
        File.gob("#{@theme_path}/public/stylesheets/*").each do |file|
          puts "Installing #{@theme}/public/stylesheets/#{file}"
        end
        FileUtils.cp_r "#{@theme_path}/public/stylesheets","#{path}/public"  if File.directory?  "#{@theme_path}/public/stylesheets"                 
      end
  
      def install_layouts
        return  nil unless File.directory? "#{@theme_path}/app/views/layouts"      
        File.gob("#{@theme_path}/app/views/layouts/*").each do |file|
          puts "Installing #{@theme}/app/views/layouts/#{file}"
        end
        FileUtils.cp_r "#{@theme_path}/app/views/layouts","#{path}/app/views"  if File.directory?  "#{@theme_path}/views/layouts"                 
      end
  
      def install_javascript 
        return  nil unless File.directory? "#{@theme_path}/public/javascripts"      
        File.gob("#{@theme_path}/public/javascripts/*").each do |file|
          puts "Installing #{@theme}/public/javascripts/#{file}"
        end
        FileUtils.cp_r "#{@theme_path}/public/javascripts","#{path}/public"  if File.directory?  "#{@theme_path}/public/javascripts"                 
      end
  
      def install_shared           
        return  nil unless File.directory? "#{SHARED}/icons"      
        File.gob("#{SHARED}/icons/*").each do |file|
          puts "Installing #{SHARED}/icons/#{file}"
        end
        FileUtils.cp_r "#{SHARED}/icons","#{path}/public/images/"  if File.directory?  "#{SHARED}/icons"                        
      end       
  end   
end  
