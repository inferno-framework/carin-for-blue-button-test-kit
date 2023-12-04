require_relative 'naming'
require_relative 'special_cases'

module CarinForBlueButtonTestKit
  class Generator
        class IncludeSearchTestGenerator

          attr_accessor :group_metadata, :search_param, :base_output_dir

          def initialize(group_metadata, search_param, base_output_dir)
            self.group_metadata = group_metadata
            self.search_param = search_param
            self.base_output_dir = base_output_dir
          end

          def generate
            FileUtils.mkdir_p(output_file_directory)
            File.open(output_file_name, 'w') { |f| f.write(output) }

            group_metadata.add_test(
              id: test_id,
              file_name: base_output_file_name
            )
          end

          def template
            @template ||= File.read(File.join(__dir__, 'templates', 'include_search.rb.erb'))
          end

          def output
            @output ||= ERB.new(template).result(binding)
          end

          def output_file_directory
            File.join(base_output_dir, profile_identifier)
          end

          def output_file_name
            File.join(output_file_directory, base_output_file_name)
          end

          def profile_identifier
            Naming.snake_case_for_profile(group_metadata)
          end

          def base_output_file_name
            file_name = class_name
            file_name.sub!(resource_type, '')
            file_name = file_name.underscore
            file_name.sub!("#{profile_identifier}", 'incl')
            "#{file_name}.rb"
          end

          def test_id
            "c4bb_#{group_metadata.reformatted_version}_#{profile_identifier}_include_#{remove_star}_search_test"
          end

          def module_name
            "CARIN4BB#{group_metadata.reformatted_version.upcase}"
          end

          def class_name
            "#{Naming.upper_camel_case_for_profile(group_metadata)}#{remove_star}SearchTest"
          end

          def input_id
            "c4bb_#{group_metadata.reformatted_version}_#{profile_identifier}__id_search_test_param"
          end

          def input_title
            "#{resource_type} search parameter for _id"
          end

          def input_description
            "#{resource_type} search parameter: _id"
          end
          
          def include_parameters
            case search_param
            when 'ExplanationOfBenefit:payee'
                [{path: 'payee.party', target: 'Organization'}]
            when 'ExplanationOfBenefit:*'
                search_definitions = ['patient', 'provider', 'care-team', 'coverage', 'insurer']
                include_params = []
                search_definitions.each do |search_def|
                  target_paths = group_metadata.search_definitions[search_def.to_sym][:target_paths]
                  include_params = include_params + target_paths
                end
                include_params
            else
              group_metadata.search_definitions[include_search_type.to_sym][:target_paths]
            end
          end

          def include_search_type
            search_param.sub("#{resource_type}:", "")
          end

          def removed_hyphen
            search_param.gsub('-', '')
          end

          def remove_colon
            removed_hyphen.gsub(':', '_')
          end

          def remove_star
            remove_colon.gsub('*', 'All')
          end

          def resource_type
            group_metadata.resource
          end

          def include_search_param
            search_param
          end

          def description
            <<~DESCRIPTION
              Tests that the server responds correctly when using _include="#{search_param}" as a search parameter 
            DESCRIPTION
          end
        end
    end
end
