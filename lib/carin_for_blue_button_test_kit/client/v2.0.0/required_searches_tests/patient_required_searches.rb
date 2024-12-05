require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientPatientRequiredSearches < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :patient_required_searches
    title 'Patient required search parameters'
    description %(
      This test will look through all the requests to find a Patient search request with each of the following
      required search parameters specified for the Patient resource in the
      [CARIN for Blue Button](https://hl7.org/fhir/us/carin-bb/STU2/CapabilityStatement-c4bb.html#patient)
      and [US Core Client](https://www.hl7.org/fhir/us/core/STU3.1.1/CapabilityStatement-us-core-client.html#patient)
      Capability Statements:
        * _id
        * birthdate
        * family
        * gender
        * given
        * identifier
        * name
        * birthdate+family
        * family+gender
        * birthdate+name
        * gender+name
    )
    input :access_token

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@14'

    def required_searches
      [
        '_id',
        'birthdate',
        'family',
        'gender',
        'given',
        'identifier',
        'name',
        'birthdate+family',
        'family+gender',
        'birthdate+name',
        'gender+name'
      ]
    end

    run do
      search_params = resource_previous_search_params(:PatientSearch)
      skip_if search_params.nil?, 'No search requests made for Patient resource'

      missing_params = []
      required_searches.each do |search_param|
        if search_param.include?('+')
          split_param = search_param.split('+')
          unless search_params.include?(split_param.first) && search_params.include?(split_param.last)
            missing_params.append(search_param)
          end
        else
          missing_params.append(search_param) unless search_params.include?(search_param)
        end
      end

      assert(missing_params.empty?, %(
        Did not find any requests made with the following required search parameters:
        #{missing_params.join(', ')}
      ))
    end
  end
end
