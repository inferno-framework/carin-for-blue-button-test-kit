require_relative '../../../must_support_test'
require_relative './patient_read_test'
require_relative '../../../generator/group_metadata'

module CARINForBlueButton
  module CARIN4BBV120
    class PatientMustSupportTest < Inferno::Test
      include CARINForBlueButton::MustSupportTest
      include CARINForBlueButton::CARIN4BBV120

      title 'All must support elements are provided in the Patient resources returned'
      description %(
        CARIN for Blue Button Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the CARIN for Blue Button Capability
        Statement. This test will look through the Patient resources
        found previously for the following must support elements:

        * Patient.address
        * Patient.address.city
        * Patient.address.country
        * Patient.address.district
        * Patient.address.line
        * Patient.address.period
        * Patient.address.postalCode
        * Patient.address.state
        * Patient.birthDate
        * Patient.communication.language
        * Patient.deceased[x]
        * Patient.gender
        * Patient.identifier
        * Patient.identifier.system
        * Patient.identifier.value
        * Patient.identifier:memberid
        * Patient.identifier:uniquememberid
        * Patient.meta
        * Patient.meta.lastUpdated
        * Patient.name
        * Patient.name.family
        * Patient.name.given
        * Patient.telecom.system
        * Patient.telecom.use
        * Patient.telecom.value
      )

      id :c4bb_v120_patient_must_support_test

      uses_request :patient_request

      def resource_type
        'Patient'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      def patient_resource
        resource
        #CARIN4BBV120::PatientReadTest.new().patient_resource
      end 

      run do
        perform_must_support_test([patient_resource])
      end
    end
  end
end
