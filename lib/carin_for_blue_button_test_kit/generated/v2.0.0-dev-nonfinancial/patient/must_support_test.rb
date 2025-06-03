# frozen_string_literal: true

require_relative '../../../must_support_test'
require_relative './read_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class PatientMustSupportTest < Inferno::Test
      include CarinForBlueButtonTestKit::MustSupportTest
      include CarinForBlueButtonTestKit::CARIN4BBV200DEVNONFINANCIAL

      title 'All must support elements are provided in the Patient resources returned'
      description %(
        CARIN for Blue Button Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the CARIN for Blue Button Capability
        Statement. This test will look through the Patient resources
        found previously for the following must support elements:

                * Patient.address
        * Patient.address.city
        * Patient.address.country
        * Patient.address.line
        * Patient.address.period
        * Patient.address.postalCode
        * Patient.address.state
        * Patient.birthDate
        * Patient.communication
        * Patient.communication.language
        * Patient.deceased[x]
        * Patient.extension:birthsex
        * Patient.extension:ethnicity
        * Patient.extension:race
        * Patient.gender
        * Patient.identifier
        * Patient.identifier.system
        * Patient.identifier.value
        * Patient.identifier:memberid
        * Patient.identifier:memberid.system
        * Patient.identifier:memberid.value
        * Patient.identifier:uniquememberid
        * Patient.identifier:uniquememberid.system
        * Patient.identifier:uniquememberid.value
        * Patient.meta
        * Patient.meta.lastUpdated
        * Patient.name
        * Patient.name.family
        * Patient.name.given
        * Patient.telecom
        * Patient.telecom.system
        * Patient.telecom.use
        * Patient.telecom.value
      )
      verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@11'

      id :c4bb_v200devnonfinancial_patient_must_support_test

      def resource_type
        'Patient'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
