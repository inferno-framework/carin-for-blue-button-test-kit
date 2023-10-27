require_relative 'explanation_of_benefit_oral/explanation_of_benefit_oral_read_test'
    require_relative 'explanation_of_benefit_oral/explanation_of_benefit_oral_validation_test'
    require_relative 'explanation_of_benefit_oral/explanation_of_benefit_oral_must_support_test'
    
    module CarinForBlueButtonTestKit
      module CARIN4BBV200DEVNONFINANCIAL
        class ExplanationOfBenefitOralGroup < Inferno::TestGroup
          title 'ExplanationOfBenefit Oral Tests'
          short_description 'Verify support for the server capabilities required by the C4BB ExplanationOfBenefit Oral.'
          description %(
            # Background

            The CARIN for Blue Button ExplanationOfBenefit Oral sequence verifies that the system under test is
            able to provide correct responses for ExplanationOfBenefit queries. These queries
            must contain resources conforming to the C4BB ExplanationOfBenefit Oral as
            specified in the CARIN for Blue Button v2.0.0-dev-nonfinancial Implementation Guide.

            # Testing Methodology


            ## Must Support
            Each profile contains elements marked as "must support". This test
            sequence expects to see each of these elements at least once. If at
            least one cannot be found, the test will fail. The test will look
            through the ExplanationOfBenefit resources found in the first test for these
            elements.

            ## Profile Validation
            Each resource returned from the first search is expected to conform to
            the [C4BB ExplanationOfBenefit Oral](http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-ExplanationOfBenefit-Oral). Each element is checked against
            terminology binding and cardinality requirements.

            Elements with a required binding are validated against their bound
            ValueSet. If the code/system in the element is not part of the ValueSet,
            then the test will fail.

            ## Reference Validation
            At least one instance of each external reference in elements marked as
            "must support" within the resources provided by the system must resolve.
            The test will attempt to read each reference found and will fail if no
            read succeeds.

          )
    
          id :c4bb_v200devnonfinancial_explanation_of_benefit_oral
          run_as_group
    
          def self.metadata
            @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'explanation_of_benefit_oral', 'metadata.yml'), aliases: true))
          end
      
          test from: :c4bb_v200devnonfinancial_explanation_of_benefit_oral_read_test
          test from: :c4bb_v200devnonfinancial_explanation_of_benefit_oral_validation_test
          test from: :c4bb_v200devnonfinancial_explanation_of_benefit_oral_must_support_test
        end
      end
    end
    