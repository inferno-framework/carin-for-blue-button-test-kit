module CarinForBlueButtonTestKit
    class InstantiatesTest < Inferno::Test
      id :carin_bb_instantiate
      title 'Server instantiates CARIN BlueButton '
      description %(
          This test inspects the CapabilityStatement returned by the server to
          verify that the server instantiates http://hl7.org/fhir/us/carin-bb/CapabilityStatement/c4bb
        )

      uses_request :capability_statement

      run do
        assert_resource_type(:capability_statement)
        capability_statement = resource

        assert capability_statement.instantiates.include?('http://hl7.org/fhir/us/carin-bb/CapabilityStatement/c4bb'),
          "Server CapabilityStatement.instantiates does not include 'http://hl7.org/fhir/us/carin-bb/CapabilityStatement/c4bb'"
      end
    end
  end
