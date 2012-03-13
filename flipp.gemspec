lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'bundler'

Gem::Specification.new do |s|
  s.name        = "flipp"
  s.version     = '0.0.2.5'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mike Pack"]
  s.email       = ["mikepackdev@gmail.com"]
  s.homepage    = "http://www.mikepackdev.com"
  s.summary     = %q{Switch development databases upon branch checkouts.}
  s.description = %q{To alleviate issues around highly divergent development databases on feature/refactor branches, flipp helps switch databases upon new branch checkouts.}

  s.required_rubygems_version = ">= 1.3.6"

  s.add_runtime_dependency 'activerecord'
  s.add_runtime_dependency 'database_exporter'

  s.files = %w( README.md Rakefile flipp.gemspec ) + Dir["lib/**/*.rb"]
  s.test_files = Dir["spec/**/*.rb"]
  s.require_paths = ["lib"]
end