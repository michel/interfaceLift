require File.dirname(__FILE__) + '/spec_helper'

include InterfaceLift
describe Catalog do
  
 before(:all) do
   FileUtils.stubs(:mkdir_p)
 end

  context "Initialize" do
    it "should initialize with a path that contains the users current themes" do
      @path = "~/.interfacelift"
      @cat = Catalog.new(@path)
      @cat.catalog_path.should == @path
    end
    
    it "should take a default path when no path is provided" do
      @cat = Catalog.new
      @cat.catalog_path.should == Catalog::DEFAULT_CATELOG_PATH
    end    
  end
  
  context "Catalog content" do
    before(:each) do
      @cat = Catalog.new(File.dirname(__FILE__) + "/assets")
    end
    
    it "should provide a list of the available themes in the given path" do
      themes = ["test_theme", "test_theme2", "bright_admin"]   
      @cat.themes.sort == themes.sort      
      # (@cat.themes + (themes)).uniq.size.should == 3
    end
    
    
    it "should check if a theme exists" do
      @cat.theme_exists?("test_theme2").should == true
      @cat.theme_exists?("test_theme3").should == false
    end
    
    
    context "Updating a theme from a git repo" do
      
      before(:each) do
        @git_mock = mock('Git', :repo => mock("git", :path => "fakepath"))
        Git.stubs(:open).returns(@git_mock)
      end

      it "should return true when its updated" do
        @git_mock.stubs(:pull).returns("Updating 35d573d..546fee5")
        @cat.update_theme("test_theme2").should == true
      end 
      
      it "should return false when there are no updates" do
        @git_mock.stubs(:pull).returns("Already up-to-date.")
        @cat.update_theme("test_theme2").should == false
      end
      
    end

    it "should check if the directory contains a git repo" do
      @git_mock = mock('Git', :repo => mock("git", :path => "fakepath"))
      Git.stubs(:open).returns(@git_mock)
      @cat.git_repo?("test_theme2").should == true
    end
    
    context "Download a theme from a git repo" do      
      it "should return an exception when given an invalid repository path" do
        lambda {  @cat.add_theme("mysweettheme", "git://fakepath.git")  }.should raise_error Git::GitExecuteError
      end
      
      it "should download theme from a remote repository" do
        @git_mock = mock('Git', :repo => mock("git", :path => "fakepath"))
        Git.stubs(:clone).returns(@git_mock)
        @cat.add_theme("mysweettheme", "git://mysickgit.git").should == true
      end           
    end    
    
    
    context "Removing a theme" do
      it "should remove a theme and return true" do
        @cat.stubs(:theme_exists?).returns(true)
        theme_name = "non_existing_theme"
        FileUtils.stubs(:rm_rf).with("#{@cat.catalog_path}/#{theme_name}").returns(true)
        @cat.remove_theme(theme_name).should == true
      end
      
      it "should return false when a theme doesn't exist in catalog" do
        @cat.stubs(:theme_exists?).returns(false)
        theme_name = "non_existing_theme"
        @cat.remove_theme(theme_name).should == false
      end
    end
  end 
  
  
  it "should create the catalog folder when it does not exists" do
    non_existing_path =  "no_path"
    File.expects(:exists?).with(non_existing_path)   
    FileUtils.expects(:mkdir_p).with(non_existing_path)
    @new_cat = Catalog.new(non_existing_path)
    #@new_cat.create_catalog_path!    
  end
  
  
  

end
