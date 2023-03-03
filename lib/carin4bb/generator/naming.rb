module CARINForBlueButton
    class Generator
      module Naming
        COVERAGE = 'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Coverage'
        EXPLANATION_OF_BENEFIT = 'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-ExplanationOfBenefit'
        ORGANIZATION = 'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Organization'
        PATIENT = 'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Patient'
        PRACTITIONER = 'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Practitioner'
        RELATED_PERSON = 'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-RelatedPerson'
  
        class << self
          def resources_with_multiple_profiles
            ['ExplanationOfBenefit']
          end
  
          def resource_has_multiple_profiles?(resource)
            resources_with_multiple_profiles.include? resource
          end
  
          def snake_case_for_profile(group_metadata)
            resource = group_metadata.resource
            return resource.underscore unless resource_has_multiple_profiles?(resource)
  
            group_metadata.name
              .delete_prefix('C4BB_')
              .underscore
          end
  
          def upper_camel_case_for_profile(group_metadata)
            snake_case_for_profile(group_metadata).camelize
          end
        end
      end
    end
  end
  