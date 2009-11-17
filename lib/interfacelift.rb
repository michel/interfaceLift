module  InterfaceLift  
   VERSION = "0.0.1"
   DEFAULT_CATELOG_PATH =  "~/.interfacelift"
end
$LOAD_PATH << File.expand_path(File.dirname(__FILE__))
require "catalog"
require "installer"
require "theme_manager"