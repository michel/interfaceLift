module InterfaceLift
  class ThemeManager
    def available_themes
       Dir.foreach("#{File.expand_path(File.join(File.dirname(__FILE__), '..'))}/lib/templates") do |t|
         puts t unless t == "shared" || t == ".." || t == "."  ||  t == ".DS_Store"      
       end
    end
  end
end