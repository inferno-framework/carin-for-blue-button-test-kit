require_relative './tests/conformance_support_test'
require_relative './tests/fhir_version_test'
require_relative './tests/json_support_test'
require_relative './tests/profile_support_test'
require_relative './tests/instantiates_test'

module CarinForBlueButtonTestKit
    class CapabilityStatmentGroup < Inferno::TestGroup
      title 'Capability Statement Tests'
      id :capability_statement_group
      description %(
        This test group inspects the CapabilityStatement returned by the server.
      )

      run_as_group

      PROFILES = {
        'Coverage' => ['http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Coverage'].freeze,
        'ExplanationOfBenefit' => [
          'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-ExplanationOfBenefit',
          'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-ExplanationOfBenefit-Inpatient-Institutional',
          'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-ExplanationOfBenefit-Outpatient-Institutional',
          'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-ExplanationOfBenefit-Oral',
          'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-ExplanationOfBenefit-Pharmacy',
          'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-ExplanationOfBenefit-Professional-NonClinician'
        ].freeze,
        'Organization' => ['http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Organization'].freeze,
        'Patient' => ['http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Patient'].freeze,
        'Practitioner' => ['http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Practitioner'].freeze,
        'RelatedPerson' => ['http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-RelatedPerson'].freeze
    }.freeze

      
    # test from: :carin_bb_conformance_support
    # test from: :carin_bb_json_support

    # test from: :carin_bb_profile_support do
    #   config(
    #     options: { carin_bb_resources: PROFILES.keys }
    #   )
    # end

      test from: :carin_bb_instantiate
    end
end