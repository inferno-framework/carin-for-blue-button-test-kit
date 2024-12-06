require_relative '../urls'

module CarinForBlueButtonTestKit
  class ClientAttestationTest < Inferno::Test
    include URLs
    title 'CARIN Claims Data Client Attestation'
    description %(
      Attest that the all claims data was able to be received and processed by the client.
    )
    id :client_claims_data_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@3',
                          'hl7.fhir.us.carin-bb_2.0.0@13'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: %(
          I attest that the client system under test was able to receive, process, and retain all of the requested
          CARIN for Blue Button claims data, including all of the profile data elements that have a minimum cardinality
          greater than or equal to 1 and/or flagged as Must Support as defined by that profiles StructureDefinition
          for each resource.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        )
      )
    end
  end
end
