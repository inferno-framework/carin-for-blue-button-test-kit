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

namespace :requirements do
  desc 'Generate requirements coverage CSV'
  task :generate_coverage do
    require 'inferno'
    Inferno::Application.start(:suites)

    require_relative 'lib/inferno_requirements_tools/tasks/map_requirements'
    InfernoRequirementsTools::Tasks::MapRequirements.new.run
  end
end

namespace :requirements do
  desc 'Check if requirements coverage CSV is up-to-date'
  task :check_coverage do
    require 'inferno'
    Inferno::Application.start(:suites)

    require_relative 'lib/inferno_requirements_tools/tasks/map_requirements'
    InfernoRequirementsTools::Tasks::MapRequirements.new.run_check
  end
end

namespace :requirements do
  desc 'Collect requirements and planned not tested requirements into CSVs'
  task :collect_requirements, [:input_directory] => [] do |_, args|
    require_relative 'lib/inferno_requirements_tools/tasks/collect_requirements'
    InfernoRequirementsTools::Tasks::CollectRequirements.new.run(args.input_directory)
  end
end

namespace :requirements do
  desc 'Check if requirements and planned not tested CSVs are up-to-date'
  task :check_collected_requirements, [:input_directory] => [] do |_, args|
    require_relative 'lib/inferno_requirements_tools/tasks/collect_requirements'
    InfernoRequirementsTools::Tasks::CollectRequirements.new.run_check(args.input_directory)
  end
end
