# frozen_string_literal: true

require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class EobOralExplanationOfBenefit_insurerSearchTest < Inferno::Test
      include CarinForBlueButtonTestKit::CarinSearchTest

      title 'Server returns valid results for ExplanationOfBenefit search by id + _include=ExplanationOfBenefit:insurer'
      description %(Tests that the server responds correctly when using _include="ExplanationOfBenefit:insurer" as a search parameter

      )

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'ExplanationOfBenefit',
          search_param_names: ['_include'],
          include_parameters: [{ path: 'insurer', target: ['Organization'] }]
        )
      end

      id :c4bb_v200_eob_oral_include_ExplanationOfBenefit_insurer_search_test

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:explanationofbenefit_resources] ||= {}
      end

      run do
        run_include_search('ExplanationOfBenefit:insurer')
      end
    end
  end
end
