require_relative '../urls'

module CarinForBlueButtonTestKit
  class C4BBV200ClientRegistrationOtherAuthAttest < Inferno::Test
    include URLs

    id :c4bb_v200_client_reg_other_auth_attest
    title 'Verify that the client supports an approach for authenticating itself to the server (Attestation)'
    description %(
      Since a standard auth approach was not chosen for this session, this test provides testers with an
      opportunity to attest to their client's ability to authenticate itself to a server
      using a method that this Inferno test suite does not support, such as mutual authentication
      TLS.
    )

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: %(
          **Other Authentication Attestation**:

          I attest that the client system can authenticate itself with a CARIN server using
          a mechanism other than the SMART App Launch or UDAP authorization code
          flows.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the above statement is true.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the above statement is false.
        )
      )
    end
  end
end
