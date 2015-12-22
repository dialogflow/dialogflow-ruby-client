# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'api-ai-ruby/constants'

Gem::Specification.new do |spec|
  spec.name          = 'api-ai-ruby'
  spec.version       = ApiAiRuby::Constants::VERSION
  spec.authors       = ['api.ai']
  spec.email         = ['shingarev@api.ai']
  spec.summary       = %q{ruby SDK for https://api.ai }
  spec.description   = %q{Plugin makes it easy to integrate your Ruby application with https://api.ai natural language processing service.}
  spec.homepage      = 'https://api.ai'
  spec.license       = 'Apache 2.0 License'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_dependency 'http', '~> 0.9.4'
  spec.add_dependency 'http-form_data', '~> 1.0'

end
