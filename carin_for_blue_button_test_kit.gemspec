require_relative 'lib/carin_for_blue_button_test_kit/version'

Gem::Specification.new do |spec|
  spec.name          = 'carin_for_blue_button_test_kit'
  spec.version       = CarinForBlueButtonTestKit::VERSION
  spec.authors       = ['John Morrison']
  spec.email         = ['jmorrison@leaporbit.com']
  spec.date          = Time.now.utc.strftime('%Y-%m-%d')
  spec.summary       = 'CARIN IG for Blue Button® Test Kit'
  spec.description   = 'CARIN IG for Blue Button® Test Kit'
  spec.homepage      = 'https://github.com/inferno-framework/carin-for-blue-button-test-kit'
  spec.license       = 'Apache-2.0'
  spec.add_runtime_dependency 'inferno_core', '~> 0.4.37'
  spec.add_runtime_dependency 'smart_app_launch_test_kit', '~> 0.4'
  spec.add_development_dependency 'database_cleaner-sequel', '~> 1.8'
  spec.add_development_dependency 'factory_bot', '~> 6.1'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'webmock', '~> 3.11'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.1.2')
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/inferno-framework/carin-for-blue-button-test-kit'
  spec.files = [
    Dir['lib/**/*.rb'],
    Dir['lib/**/*.json'],
    Dir['lib/**/*.tgz'],
    Dir['lib/**/*.yml'],
    'LICENSE'
  ].flatten

  spec.require_paths = ['lib']
end
