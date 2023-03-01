module InfernoTemplate
  module Patient
    class PatientMustSupportTest < Inferno::Test
      include InfernoTemplate::MustSupportTest

      title 'All must support elements are provided in the Patient resources returned'
      description %(
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the CARIN for Blue Button Capability Statement.
      )
      id: carin4bb_patient_must_support

      input :patient_id
    end
  end
end
