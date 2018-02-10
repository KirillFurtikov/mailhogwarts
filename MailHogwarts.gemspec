lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mailhogwarts/version'

Gem::Specification.new do |spec|
  spec.name          = 'mailhogwarts'
  spec.version       = MailHogwarts::VERSION
  spec.authors       = ['Furtikov Kirill']
  spec.email         = ['kafurtikov@gmail.com']

  spec.summary       = 'A simple Ruby gem for using MailHog API'
  spec.description   = 'A Ruby gem for rapid API testing with great conventions.'
  spec.homepage      = 'https://github.com/KirillFurtikov/mailhogwarts'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_dependency 'rest-client', '~> 2.0'
end
