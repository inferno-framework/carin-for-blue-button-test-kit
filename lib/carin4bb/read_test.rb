module CARINForBlueButton
    module ReadTest
      def all_scratch_resources
        scratch_resources[:all] ||= []
      end
  
      def perform_read_test(resources, reply_handler = nil)
        skip_if resources.blank?, no_resources_skip_message
  
        if config.options[:read_all_resources]
          resources.each do |id|
            fhir_read(resource_type, id)
            read_and_validate(resource)
          end
        else
          fhir_read(resource_type, resources.first)
          read_and_validate(resource)
        end
      end
  
      def read_and_validate(resource_to_read)
        id = resource_id(resource_to_read)

        assert_response_status(200) 
        assert_resource_type(resource_type, resource: resource_to_read)
        assert resource.id.present? && resource.id == id, bad_resource_id_message(id)
  
        if resource_to_read.is_a?(FHIR::Model)
          all_scratch_resources << resource
        end
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
  