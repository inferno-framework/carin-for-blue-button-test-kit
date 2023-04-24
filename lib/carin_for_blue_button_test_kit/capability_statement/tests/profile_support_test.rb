module CarinForBlueButtonTestKit
  class ProfileSupportTest < Inferno::Test
    id :carin_bb_profile_support
    title 'Capability Statement lists support for required CARIN BlueButton Profiles'
    description %(
      The CARIN BlueButton Implementation Guide states:

      ```
      The C4BB Server SHALL:
      1. Support all profiles defined in this Implementation Guide.
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

      carin_bb_resources = config.options[:carin_bb_resources]
      carin_bb_resources.each do |resource_type|
        fail_message = 'CARIN for Blue Button ' + resource_type + ' profile not supported'
        assert supported_resources.include?(resource_type), fail_message
      end
    end
  end
end
