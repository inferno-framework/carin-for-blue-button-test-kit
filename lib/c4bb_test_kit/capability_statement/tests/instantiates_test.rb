module C4BBTestKit
    class InstantiatesTest < Inferno::Test
      id :carin_bb_instantiate
      title 'Server instantiates CARIN BlueButton '
      description %(
          This test inspects the CapabilityStatement returned by the server to
          verify that the server instantiates http://hl7.org/fhir/us/carin-bb/CapabilityStatement/c4bb
        )
      
      # Makes_request step (see comment below)
      makes_request :capability_statement

      ##############################################################
      # ATTENTION: If other capability tests are added,
      # USE "uses_request" line below and move makes_request 
      # lines to the first test in the group
      ##############################################################
      # uses_request :capability_statement
  
      run do
        # Makes_request steps (see comment above)
        fhir_client.set_no_auth
        fhir_get_capability_statement(name: :capability_statement)

        assert_resource_type(:capability_statement)
        capability_statement = resource
  
        assert capability_statement.instantiates.include?('http://hl7.org/fhir/us/carin-bb/CapabilityStatement/c4bb'),
          "Server CapabilityStatement.instantiates does not include 'http://hl7.org/fhir/us/carin-bb/CapabilityStatement/c4bb'"
      end
    end
  end