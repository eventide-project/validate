# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-validate'
  s.version = '0.3.1.3'
  s.summary = 'Interface and protocol for validating and validation discovery'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/validate'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.3.3'

  s.add_development_dependency 'test_bench'
end
