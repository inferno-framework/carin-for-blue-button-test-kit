module CARINForBlueButton
  class ProfileSupportTest < Inferno::Test
    id :carin_bb_profile_support
    title 'Capability Statement lists support for required US Core Profiles'
    description %(
      The US Core Implementation Guide states:

      ```
      The US Core Server SHALL:
      1. Support the US Core Patient resource profile.
      2. Support at least one additional resource profile from the list of US
         Core Profiles.

      In order to support USCDI, servers must support all USCDI resources.
      ```
    )
    uses_request :capability_statement

    run do
      assert_resource_type(:capability_statement)
      capability_statement = resource

      supported_resources =
        capability_statement.rest
          &.each_with_object([]) do |rest, resources|
            rest.resource.each { |resource| resources << resource.type }
          end.uniq

      assert supported_resources.include?('Patient'), 'CARIN for Blue Button Patient profile not supported'

      carin_bb_resources = config.options[:carin_bb_resources]

      other_resources = carin_bb_resources.reject { |resource_type| resource_type == 'Patient' }
      other_resources_supported = other_resources.any? { |resource| supported_resources.include? resource }
      assert other_resources_supported, 'No CARIN for Blue Button resources other than Patient are supported'

      if config.options[:required_resources].present?
        missing_resources = config.options[:required_resources] - supported_resources

        missing_resource_list =
          missing_resources
          .map { |resource| "`#{resource}`" }
          .join(', ')

        assert missing_resources.empty?,
               "The CapabilityStatement did not list support for the following resources: #{missing_resource_list}"
      end
    end
  end
end
