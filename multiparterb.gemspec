# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'multiparterb/version'

Gem::Specification.new do |s|
  s.name        = 'multiparterb'
  s.version     = MultipartErb::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.summary     = 'Multipart templates made easy'
  s.email       = 'ian.vaughan@econsultancy.com'
  s.homepage    = 'http://github.com/'
  s.description = 'Multipart templates made easy'
  s.authors     = ['Ian Vaughan']
  s.license     = 'MIT'

  s.files         = Dir['MIT-LICENSE', 'README.md', 'lib/**/*']
  s.test_files    = Dir['test/**/*.rb']
  s.require_paths = ['lib']

  s.add_runtime_dependency 'nokogiri'
end
