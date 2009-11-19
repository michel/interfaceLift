module InterfaceLift
  class Installer
      attr_reader :path, :theme, :theme_path
  
  
      def initialize(path,theme,catalog_path=InterfaceLift::DEFAULT_CATALOG_PATH)      
        @path = path
        @theme = theme     
        @theme_path =  "#{catalog_path}/#{theme}"      

        raise "Given path does not contain a rails app." unless File.directory? "#{@path}/public" 
        raise "Theme #{@theme} is not available." unless File.directory? @theme_path   
      end
     
      def install!  
        install_images
        install_stylesheets
        install_layouts
        install_javascript
        theme_install
      end
      
      private
      
      def theme_install   
          return nil unless File.file? "#{@theme_path}/install.rb"
          instance_eval(File.open("#{@theme_path}/install.rb").read) 
      end  
      
      def gsub_file(relative_destination, regexp, *args, &block)
        dest_path = "#{path}#{relative_destination}"
        content = File.read(dest_path).gsub(regexp, *args, &block)
        File.open(dest_path, 'wb') { |file| file.write(content) }
      end
      
      def install_images      
        return  nil unless File.directory? "#{@theme_path}/public/images"      
        Dir.glob("#{@theme_path}/public/images/*").each do |file|
          puts "Installing public/images/#{file.split("/").last}"
        end  
        FileUtils.cp_r "#{@theme_path}/public/images","#{path}/public" 
      end
  
      def install_stylesheets 
        return  nil unless File.directory? "#{@theme_path}/public/images"      
        Dir.glob("#{@theme_path}/public/stylesheets/*").each do |file|
          puts "Installing public/stylesheets/#{file.split("/").last}"
        end
        FileUtils.cp_r "#{@theme_path}/public/stylesheets","#{path}/public"         
      end
  
      def install_layouts
        return  nil unless File.directory? "#{@theme_path}/app/views/layouts"      
        Dir.glob("#{@theme_path}/app/views/layouts/*").each do |file|
          puts "Installing app/views/layouts/#{file.split("/").last}"
        end
        FileUtils.cp_r "#{@theme_path}/app/views/layouts","#{path}/app/views"    
      end
  
      def install_javascript 
        return  nil unless File.directory? "#{@theme_path}/public/javascripts"      
        Dir.glob("#{@theme_path}/public/javascripts/*").each do |file|
          puts "Installing public/javascripts/#{file.split("/").last}"
        end
        FileUtils.cp_r "#{@theme_path}/public/javascripts","#{path}/public"                
      end
     
  end   
end  
