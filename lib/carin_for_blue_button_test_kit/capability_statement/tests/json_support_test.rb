module CarinForBlueButtonTestKit
  class JSONSupportTest < Inferno::Test
    id :carin_bb_json_support
    title 'FHIR server capability states JSON support'
    description %(
      FHIR provides multiple [representation
      formats](https://www.hl7.org/fhir/formats.html) for resources, including
      JSON and XML. CARIN BlueButton profiles require servers to use the [JSON
      representation](https://www.hl7.org/fhir/json.html):

      [```The C4BB Server **SHALL** Support json source formats for all CARIN-BB
      interactions.```](http://hl7.org/fhir/us/carin-bb/STU2/CapabilityStatement-c4bb.html#behavior)

      The FHIR conformance interaction require servers to describe which
      formats are available for clients to use. The server must explicitly
      state that JSON is supported. This is located in the [format
      element](https://www.hl7.org/fhir/capabilitystatement-definitions.html#CapabilityStatement.format)
      of the CapabilityStatement Resource.

      This test checks that one of the following values are located in the
      format field.

      * json
      * application/json
      * application/fhir+json
    )
    uses_request :capability_statement
    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@98'

    run do
      assert_resource_type(:capability_statement)

      json_formats = ['json', 'application/json', 'application/fhir+json']
      server_formats = resource.format

      assert server_formats.any? { |format| json_formats.include? format },
              'CapabilityStatement does not state support for JSON'
    end
  end
end
