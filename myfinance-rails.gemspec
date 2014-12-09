# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'myfinance/version'

Gem::Specification.new do |spec|
  spec.name          = 'myfinance-rails'
  spec.version       = Myfinance::VERSION
  spec.authors       = ['José Lopes Neto']
  spec.email         = ['jose.neto@taxweb.com.br']
  spec.summary       = %q{GEM para facilitar a uso da API do Myfinance em Aplicativos Rails}
  spec.description   = %q{GEM para facilitar a uso da API do Myfinance em Aplicativos Rails usando HTTParty}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_dependency 'httparty','~> 0.9.0'
end
