SPEC_ROOT = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH << SPEC_ROOT
GEM_ROOT =  File.expand_path(File.join(File.dirname(__FILE__), '..'))    

$LOAD_PATH << "#{GEM_ROOT}/lib"
require "interfacelift"
                                                     
#stubbing and mocking
require 'mocha'
