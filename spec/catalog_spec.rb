require File.dirname(__FILE__) + '/spec_helper'

include InterfaceLift
describe Catalog do
  context "Initialize" do
    it "should initialize with a path that contains the users current themes" do
      @path = "~/.interfacelift"
      @cat = Catalog.new(@path)
      @cat.catalog_path.should == @path
    end
    
    it "should take a default path when no path is provided" do
      @cat = Catalog.new
      @cat.catalog_path.should == DEFAULT_CATELOG_PATH
    end    
  end
  
  context "Catalog content" do
    it "should provide a list of the available themes in the given path" do
      @cat = Catalog.new(File.dirname(__FILE__) + "/assets")
      themes = ["test_theme", "test_theme2"]      
      @cat.themes.should == themes
    end
    

    
  end
  
end
