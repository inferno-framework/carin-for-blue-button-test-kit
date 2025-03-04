require_relative 'fhir_resource_navigation'

module CarinForBlueButtonTestKit
  module MustSupportTest
    extend Forwardable
    include FHIRResourceNavigation

    def_delegators 'self.class', :metadata

    def all_scratch_resources
      scratch_resources[:all]
    end

    def perform_must_support_test(resources)
      skip_if resources.blank?, "No #{resource_type} resources were found"

      skip { assert_must_support_elements_present(resources, 'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Patient') }
    end
  end
end
