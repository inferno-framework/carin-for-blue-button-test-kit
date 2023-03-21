require_relative './tests/instantiates_test'

module CARINForBlueButton
    class CapabilityStatmentGroup < Inferno::TestGroup
      title 'Capability Statement Tests'
      id :capability_statement_group
      description %(
        This test group inspects the CapabilityStatement returned by the server.
      )

      run_as_group

      PROFILES = {} #TODO: Figure out what to add here for the profile support test

      test from: :tls_version_test,
          id: :standalone_auth_tls,
          title: 'FHIR server secured by transport layer security',
          description: %(
            Systems **SHALL** use TLS version 1.2 or higher for all transmissions
            not taking place over a secure network connection.
          ),
          config: {
            options: {  minimum_allowed_version: OpenSSL::SSL::TLS1_2_VERSION } #TODO: Confirm that  we require this version or higher
          }

      test from: :carin_bb_conformance_support
      test from: :carin_bb_fhir_version
      test from: :carin_bb_json_support

      test from: :carin_bb_profile_support do
        config(
          options: { carin_bb_resources: PROFILES.keys }
        )
      end

      test from: :carin_bb_instantiate
    end
end