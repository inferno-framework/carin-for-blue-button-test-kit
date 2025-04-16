require 'smart_app_launch_test_kit'
require_relative 'urls'
require_relative 'session_identification'
require_relative 'client_descriptions'

module CarinForBlueButtonTestKit
  class C4BBClientInitialWaitTest < Inferno::Test
    include URLs
    include SessionIdentification

    id :c4bb_v200_initial_wait_test
    title 'Client makes claims data and required search parameter requests'
    description %(
      This test will receive claims data requests and search requests until the user confirms they are done.
    )
    input :client_id,
          title: 'Client Id',
          type: 'text',
          optional: true,
          locked: true,
          description: INPUT_CLIENT_ID_LOCKED
    input :session_url_path,
          title: 'Session-specific URL path extension',
          type: 'text',
          optional: true,
          locked: true,
          description: INPUT_SESSION_URL_PATH_LOCKED
    input :smart_launch_urls,
          title: 'SMART App Launch URL(s)',
          type: 'textarea',
          locked: true,
          optional: true,
          description: SMARTAppLaunch::INPUT_SMART_LAUNCH_URLS_DESCRIPTION_LOCKED
    input :launch_context,
          title: 'Launch Context',
          type: 'textarea',
          optional: true,
          description: SMARTAppLaunch::INPUT_LAUNCH_CONTEXT_DESCRIPTION       
    input :fhir_user_relative_reference,
          title: 'FHIR User Relative Reference',
          type: 'text',
          optional: true,
          description: SMARTAppLaunch::INPUT_FHIR_USER_RELATIVE_REFERENCE

    output :launch_key
    config options: { accepts_multiple_requests: true }

    run do
      session_identifier = session_wait_identifier(client_id, session_url_path)
      session_single_resource_api_url = session_url(client_id, session_url_path)

      if smart_launch_urls.present?
        launch_key = SecureRandom.hex(32)
        output(launch_key:)
      end

      wait(
        identifier: session_identifier,
        message: %(
          Submit CARIN requests via the following method:
          * Single Resource API: `#{session_single_resource_api_url}?:search_params`, with `:endpoint`
          replaced with the endpoint you want to reach and `:search_params` replaced with the search parameters
          for the request.

          The following CARIN resources can be accessed on the Inferno Reference Server with the following IDs, and
          the following search parameters are required for each resource type:

            * Patient: `888`
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
            * Coverage: `c4bb-Coverage`
              * _id
              * patient
            * Organization: `c4bb-Organization`
              * _id
              * name
              * address
            * Practitioner: `c4bb-Practitioner`
              * _id
              * name
              * identifier
            * RelatedPerson: `c4bb-RelatedPerson`
              * _id
            * ExplanationOfBenefit: `c4bb-EOBInpatient`, `c4bb-EOBOutpatient`, `c4bb-EOBOral`, `c4bb-EOBPharmacy`,
            `c4bb-EOBProfessional`
              * _id
              * patient
              * identifier
              * _lastUpdated
              * service-date
              * service-start-date
              * billable-period-start
              * type
              * _include:
                * ExplanationOfBenefit:patient
                * ExplanationOfBenefit:provider
                * ExplanationOfBenefit:care-team
                * ExplanationOfBenefit:coverage
                * ExplanationOfBenefit:insurer
                * ExplanationOfBenefit:payee
                * ExplanationOfBenefit:*


          [Click here](#{resume_claims_data_url}?test_run_identifier=#{session_identifier}) when done.
        ),
        timeout: 900
      )
    end
  end
end
