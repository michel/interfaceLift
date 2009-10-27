require 'rubygems'
require 'rake'
   
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "interfacelift"
    gem.summary = %Q{Installs templates in rails applications}
    gem.description = %Q{Collection of cool layouts to use in your rails apps.}
    gem.email = "michel@re-invention.nl"
    gem.homepage = "http://github.com/michel/interfacelift"
    gem.authors = ["Michel de Graaf"]
    gem.add_development_dependency "thoughtbot-shoulda"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end                

require 'spec/rake/spectask'
desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/*_spec.rb']
	t.spec_opts = ['--options', "\"spec/spec.opts\""]
end


begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

                           

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "interfacelift #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

