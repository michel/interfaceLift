require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
include InterfaceLift
describe InterfaceLift::Installer do
  
  before(:each) do       
    @path = "/tmp"
    @theme = "test_theme"
    @theme_path = "#{GEM_ROOT}/lib/templates/#{@theme}"        
  end

  def valid_arguments
    File.expects(:directory?).with("#{@path}/public").returns(true)
    File.expects(:directory?).with(@theme_path).returns(true)
  end
  
  describe "Initialization" do
      
    it "Should initialize with a theme name and a path" do 
      valid_arguments
      installer = Installer.new(@path,@theme)  
      installer.theme.should == @theme
      installer.path.should == @path
    end
  
    it "Should raise an error when there the theme is not available" do
      File.expects(:directory?).with("#{@path}/public").returns(true)
      File.expects(:directory?).with(@theme_path).returns(false)     
      lambda { Installer.new(@path,@theme) }.should raise_error("Theme #{@theme} is not available.")
    end
  
  
    it "Should raise an error when the given path does not contain a rails app " do
      File.expects(:directory?).with("#{@path}/public").returns(false)
      lambda { Installer.new(@path,@theme) }.should raise_error("Given path does not contain a rails app.")    
    end          
  end
  
  describe "Installing a theme" do 
    before(:each) do
      #don't copy files over!
      valid_arguments
      @installer = Installer.new(@path,@theme)      
      File.stubs(:directory?).returns(true)
      Dir.stubs(:glob).returns([])
      FileUtils.stubs(:cp_r)             
    end
    
    after(:each) do 
      @installer.install!   
        
    end                  
    
    it "Should copy over existing images to the RAILS_ROOT/public folder" do
       FileUtils.expects(:cp_r).with("#{@theme_path}/public/images","#{@path}/public")
    end
    
    it "Should copy over existing stylesheets to the RAILS_ROOT/public folder" do
      FileUtils.expects(:cp_r).with("#{@theme_path}/public/stylesheets","#{@path}/public")
    end
    
    it "Should copy over templates to the RAILS_ROOT/app/views/layout folder" do
      FileUtils.expects(:cp_r).with("#{@theme_path}/app/views/layouts","#{@path}/app/views")
    end      
    
    it "Should copy over javascripts to the RAILS_ROOT/public folder" do
      FileUtils.expects(:cp_r).with("#{@theme_path}/public/javascripts","#{@path}/public")
    end
    
    it "Should copy over shared resources to the RAILS_ROOT/public folder" do
      FileUtils.expects(:cp_r).with("#{GEM_ROOT}/lib/templates/shared/icons","#{@path}/public/images/")
    end   
    
  end  
  
      
end