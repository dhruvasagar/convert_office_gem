lib = File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
$:.unshift lib unless $:.include?(lib)

require 'version'

Gem::Specification.new do |s|
  s.name        = 'convert_office'
  s.version     = ConvertOffice::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Dhruva Sagar', 'Jai Keerthi']
  s.email       = ['dhruva.sagar@gmail.com', 'haiiamjai@gmail.com']
  s.summary     = 'Convert Office Gem'
  s.description = 'This is a gem for document format conversion'

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project = 'convert_office'

  s.add_development_dependency('rspec')

  s.files       = Dir.glob('lib/**/*') +  %w(LICENCE README.rdoc Rakefile)
  s.require_path= 'lib'
end
