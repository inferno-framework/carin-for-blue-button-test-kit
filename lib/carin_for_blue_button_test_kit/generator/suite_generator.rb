require_relative 'naming'

module CarinForBlueButtonTestKit
  class Generator
    class SuiteGenerator
      class << self
        def generate(ig_metadata, base_output_dir, ig_file_name)
          new(ig_metadata, base_output_dir, ig_file_name).generate
        end
      end

      attr_accessor :ig_metadata, :base_output_dir, :ig_file_name

      def initialize(ig_metadata, base_output_dir, ig_file_name)
        self.ig_metadata = ig_metadata
        self.base_output_dir = base_output_dir
        self.ig_file_name = ig_file_name
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'suite.rb.erb'))
      end

      def output
        @output ||= ERB.new(template, trim_mode: '-').result(binding)
      end

      def base_output_file_name
        "c4bb_test_suite.rb"
      end

      def class_name
        "C4BBTestSuite"
      end

      def module_name
        "CARIN4BB#{ig_metadata.reformatted_version.upcase}"
      end

      def output_file_name
        File.join(base_output_dir, base_output_file_name)
      end

      def suite_id
        "c4bb_#{ig_metadata.reformatted_version}"
      end

      def title
        "CARIN IG for Blue Button® #{ig_metadata.ig_version}"
      end

      def ig_relative_path
        "igs/#{File.basename(ig_file_name)}"
      end

      def ig_link
        case ig_metadata.ig_version
        when 'v1.1.0'
          'http://hl7.org/fhir/us/carin-bb/STU1.1'
        when 'v2.0.0'
          'http://hl7.org/fhir/us/carin-bb/STU2'
        else
          'http://hl7.org/fhir/us/carin-bb/history.html'
        end
      end

      def generate
        File.open(output_file_name, 'w') { |f| f.write(output) }
      end

      def groups
        ig_metadata.ordered_groups.select { |group| group.id.present? }
      end

      def group_id_list
        @group_id_list ||=
          groups.select.map(&:id)
      end

      def group_file_list
        @group_file_list ||=
          groups.map { |group| group.file_name.delete_suffix('.rb') }
      end

      def capability_statement_file_name
        "../capability_statement/capability_statement_group"
      end

      def capability_statement_group_id
        "c4bb_#{ig_metadata.reformatted_version}_capability_statement"
      end

      def smart_launch_file_name
        "../../custom_groups/#{ig_metadata.ig_version}/c4bb_smart_launch_group"
      end

      def smart_launch_group_id
        "c4bb_#{ig_metadata.reformatted_version}_smart_launch"
      end
    end
  end
end
