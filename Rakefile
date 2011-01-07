require 'rake'
require 'rake/rdoctask'
require 'rspec'
require 'rspec/core/rake_task'

lib = File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
$:.unshift lib unless $:.include?(lib)
require 'convert_office'
require 'version'

task :build do
  system 'gem build convert_office.gemspec'
end

task :install => :build do
  sysmtem "sudo gem install convert_office-#{ConvertOffice::VERSION}"
end

task :release => :build do
  puts "Tagging #{ConvertOffice::VERSION}..."
  system "git tag -a #{ConvertOffice::VERSION} -m 'Tagging #{ConvertOffice::VERSION}'"
  puts "Pushing to Github..."
  system "git push --tags"
  puts "Pushing to rubygems.org..."
  system "gem push convert_office-#{ConvertOffice::VERSION}.gem"
end

Rspec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
end

Rspec::Core::RakeTask.new('spec:progress') do |spec|
  spec.rspec_opts = %w(--format progress)
  spec.pattern = "spec/**/*_spec.rb"
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = "rdoc"
  rdoc.title = "convert_office #{ConvertOffice::VERSION}"
  rdoc.rdoc_files.include("README*")
  rdoc.rdoc_files.include("lib/**/*.rb")
end

task :default => :spec
