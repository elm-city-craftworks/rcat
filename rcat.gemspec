require "#{File.dirname(__FILE__)}/lib/rcat/version"

Gem::Specification.new do |s|
  s.name = "rcat"
  s.version = RCat::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Gregory Brown"]
  s.email = ["gregory.t.brown@gmail.com"]
  s.homepage = "http://github.com/sandal/rcat"
  s.summary = "Demo application for Practicing Ruby 2.9"
  s.description = "Demo application for Practicing Ruby 2.9"
  s.files = Dir.glob("{bin,lib,test,examples,doc,data}/**/*") + %w(README.md)
  s.require_path = 'lib'
  s.executables = ["rcat"]
  s.required_ruby_version = ">= 1.9.2"
  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project = "rcat"
end

