require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe InterfaceLift do
  it "Should have a version" do
   InterfaceLift::VERSION.should_not be_nil 
  end 
  
  it "Should have a DEFAULT_CATALOG_PATH" do
   InterfaceLift::DEFAULT_CATALOG_PATH.should == "#{ENV["HOME"]}/.interfacelift"
  end
  
  it "Should have an Installer class" do
    InterfaceLift::Installer.should_not be_nil
  end
end