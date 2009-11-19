module  InterfaceLift  
   VERSION = "0.0.1"
   DEFAULT_CATALOG_PATH =  "#{ENV["HOME"]}/.interfacelift"   
end
$LOAD_PATH << File.expand_path(File.dirname(__FILE__))
require "catalog"
require "fetcher"
require "installer"
require "theme_manager"