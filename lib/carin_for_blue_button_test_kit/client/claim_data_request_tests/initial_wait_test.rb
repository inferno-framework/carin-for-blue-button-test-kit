require_relative '../urls'
module CarinForBlueButtonTestKit
  class C4BBClientSubmitMustSupportTest < Inferno::Test
    include URLs

    id :initial_wait_test
    title 'Client makes claims data requests'
    description %(
      This test will receive claims data requests until the user confirms they are done.
    )
    input :access_token
    config options: { accepts_multiple_requests: true }

    run do
      wait(
        identifier: access_token,
        message: %(
          Access Token: #{access_token} \n
          Submit Carin requests via the following method:
          * Single Resource API: `#{submit_url}`, with `:endpoint` replaced with the endpoint you want to reach

          and [click here](#{resume_claims_data_url}?token=#{access_token}) when done.
        ),
        timeout: 900
      )
    end
  end
end
