require_relative 'lib/carin_for_blue_button_test_kit/version'

Gem::Specification.new do |spec|
  spec.name          = 'carin_for_blue_button_test_kit'
  spec.version       = CarinForBlueButtonTestKit::VERSION
  spec.authors       = ['John Morrison']
  spec.email         = ['jmorrison@leaporbit.com']
  spec.summary       = 'CARIN IG for Blue Button® Test Kit'
  spec.description   = 'CARIN IG for Blue Button® Test Kit'
  spec.homepage      = 'https://github.com/inferno-framework/carin-for-blue-button-test-kit'
  spec.license       = 'Apache-2.0'
  spec.add_runtime_dependency 'inferno_core', '~> 1.0', '>= 1.0.2'
  spec.add_dependency 'smart_app_launch_test_kit', '~> 1.0'
  spec.add_dependency 'udap_security_test_kit', '~> 0.12.0'
  spec.add_development_dependency 'database_cleaner-sequel', '~> 1.8'
  spec.add_development_dependency 'factory_bot', '~> 6.1'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'webmock', '~> 3.11'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.3.6')
  spec.metadata['inferno_test_kit'] = 'true'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/inferno-framework/carin-for-blue-button-test-kit'
  spec.files = `[ -d .git ] && git ls-files -z lib config/presets LICENSE`.split("\x0")

  spec.require_paths = ['lib']
end
