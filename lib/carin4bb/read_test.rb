module CARINForBlueButton
    module ReadTest
      def all_scratch_resources
        scratch_resources[:all] ||= []
      end
  
      def perform_read_test(resources, reply_handler = nil)
        skip_if resources.blank?, no_resources_skip_message
  
        if config.options[:read_all_resources]
          resources.each do |resource|
            filtered_resource = patient_resource(resource)
            read_and_validate(filtered_resource)
          end
        else
          filtered_resource = patient_resource(resources.first)
          read_and_validate(filtered_resource)
        end
      end
  
      def read_and_validate(resource_to_read)
        id = resource_id(resource_to_read)

        assert_response_status(200) 
        assert_resource_type(resource_type, resource: resource_to_read)
        assert resource.id.present? && resource.id == id, bad_resource_id_message(id)
  
        if resource_to_read.is_a? FHIR::Reference
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

      def patient_resource(given_patient_id)
        fhir_read(:patient, given_patient_id, name: :patient_request)
        #file = File.open('lib/carin4bb/ext/examples/patient_ex_1.json', 'r')
        #resource = FHIR::Json.from_json(file.read)
        resource
      end
    end
  end
  