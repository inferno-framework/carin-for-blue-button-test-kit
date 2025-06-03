# frozen_string_literal: true

module CarinForBlueButtonTestKit
  module ReadTest
    def all_scratch_resources
      scratch_resources[:all] ||= []
    end

    def perform_read_test(resources, _reply_handler = nil)
      skip_if resources.blank? && resource_ids.blank?, no_resources_skip_message
      resources_to_read_ids = resource_ids
      if resources_to_read_ids.blank?
        resources_to_read = readable_resources(resources)

        assert resources_to_read.present?, "No #{resource_type} id found."
        resources_to_read_ids = resources_to_read.map { |resource| resource_id(resource) }
      end

      if config.options[:read_all_resources]
        resources_to_read_ids.each do |id|
          read_and_validate(id)
        end
      else
        read_and_validate(resources_to_read_ids.first)
      end
    end

    def readable_resources(resources)
      resources
        .select { |resource| resource.is_a?(resource_class) || resource.is_a?(FHIR::Reference) }
        .select { |resource| (resource.is_a?(FHIR::Reference) ? resource.reference.split('/').last : resource.id).present? }
        .compact
        .uniq { |resource| resource.is_a?(FHIR::Reference) ? resource.reference.split('/').last : resource.id }
    end

    def read_and_validate(id)
      fhir_read resource_type, id

      assert_response_status(200)
      assert_resource_type(resource_type)
      assert resource.id.present? && resource.id == id, bad_resource_id_message(id)

      all_scratch_resources << resource
      all_scratch_resources.uniq!
    end

    def resource_id(resource)
      resource.is_a?(FHIR::Reference) ? resource.reference.split('/').last : resource.id
    end

    def no_resources_skip_message
      "No #{resource_type} resources appear to be available. " \
      'Please use patients with more information.'
    end

    def bad_resource_id_message(expected_id)
      "Expected resource to have id: `#{expected_id.inspect}`, but found `#{resource.id.inspect}`"
    end

    def resource_class
      FHIR.const_get(resource_type)
    end
  end
end
