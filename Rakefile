# frozen_string_literal: true

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError # rubocop:disable Lint/SuppressedException
end

namespace :db do
  desc 'Apply changes to the database'
  task :migrate do
    require 'inferno/config/application'
    require 'inferno/utils/migration'
    Inferno::Utils::Migration.new.run
  end
end

namespace :carin4bb do
  desc 'Test Generator'
  task :generate do
    require_relative 'lib/carin_for_blue_button_test_kit/generator'
    CarinForBlueButtonTestKit::Generator.generate
  end
end
