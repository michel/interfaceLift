module InterfaceLift
  class ThemeManager
    def available_themes
       Dir.foreach("#{APP_ROOT}/lib/templates") do |t|
         puts t unless t == "shared" || t == ".." || t == "."  ||  t == ".DS_Store"      
       end
    end
  end
end