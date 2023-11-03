# frozen_string_literal: true

module CarinForBlueButtonTestKit
  module CARIN4BBV110
    class C4BBSMARTLaunchGroup < Inferno::TestGroup
      id :c4bb_v110_smart_launch
      title 'SMART App Launch'
      description %(
        # Background
        Applications authorize to gain access to a patient record using the
        [SMART App Launch
        Protocol](http://hl7.org/fhir/smart-app-launch/1.0.0/)'s standalone
        launch sequence.

        # Testing Methodology
        These tests first access the server's SMART discovery endpoints and
        verify that they are available and that the server advertises support
        for the required SMART capabilities and required authorization scopes.
        They then perform a standalone launch to obtain an access token which
        can be used by the remaining tests to access patient data.
      )

      group from: :smart_discovery,
            run_as_group: true

      group from: :smart_standalone_launch,
            run_as_group: true,
            config: {
              outputs: {
                patient_id: { name: :patient_ids },
                smart_credentials: { name: :smart_credentials }
              }
            },
            description: %(
              # Background

              The [Standalone
              Launch Sequence](https://www.hl7.org/fhir/smart-app-launch/1.0.0/index.html#standalone-launch-sequence)
              allows an app, like Inferno, to be launched independent of an
              existing EHR session. It is one of the two launch methods described in
              the SMART App Launch Framework alongside EHR Launch. The app will
              request authorization for the provided scope from the authorization
              endpoint, ultimately receiving an authorization token which can be used
              to gain access to resources on the FHIR server.

              # Test Methodology

              Inferno will redirect the user to the authorization endpoint so that
              they can provide any required credentials and authorize the application.
              Upon successful authorization, Inferno will exchange the authorization
              code provided for an access token.

              For more information on the #{title}:

              * [Standalone Launch Sequence](https://www.hl7.org/fhir/smart-app-launch/1.0.0/index.html#standalone-launch-sequence)
            )
    end
  end
end
