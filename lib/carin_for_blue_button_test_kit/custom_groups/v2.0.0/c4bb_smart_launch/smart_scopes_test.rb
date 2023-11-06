# frozen_string_literal: true

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class SmartScopesTest < Inferno::Test
      id :c4bb_v200_smart_scopes
      title 'Server supports the required authorization scopes.'
      description %(
        All required scopes requested are expected to be granted.
        Server SHALL support, at a minimum, the following requested authorization scopes:
          * `openid`
          * `fhirUser`
          * `launch/patient`
          * `patient/ExplanationOfBenefit.read`
          * `patient/Coverage.read`
          * `patient/Patient.read`
          * `patient/Organization.read`
          * `patient/Practitioner.read`
          * `user/ExplanationOfBenefit.read`
          * `user/Coverage.read`
          * `user/Patient.read`
          * `user/Organization.read`
          * `user/Practitioner.read`
      )
      input :requested_scopes, :received_scopes
      uses_request :token

      PATIENT_COMPARTMENT_RESOURCE_TYPES = %w[
        Patient
        ExplanationOfBenefit
        Coverage
        Organization
        Practitioner
      ].freeze

      def patient_compartment_resource_types
        PATIENT_COMPARTMENT_RESOURCE_TYPES
      end

      def required_scopes
        config.options[:required_scopes]
      end

      def access_level_regex
        /\A(\*|\b(read|c?ru?d?s?)\b)/
      end

      def received_scope_test(scopes)
        # check if openid, fhirUser, & launch/patient was granted
        scope_subset = scopes - ['openid', 'fhirUser', 'launch/patient']
        assert scope_subset.length == scopes.length - 3,
               'openid, fhirUser, & launch/patient scopes must be supported. Received scopes: ' \
               "#{scope_subset.join(', ')}."

        granted_patient_level_resource_types = []
        granted_user_level_resource_types = []

        scope_subset.each do |scope|
          scope_pieces = scope.split('/')
          next unless scope_pieces.length == 2

          scope_type, resource_scope = scope_pieces
          next unless %w[patient user].include?(scope_type)

          resource_scope_parts = resource_scope.split('.')
          next unless resource_scope_parts.length == 2

          resource_type, access_level = resource_scope_parts
          next unless access_level =~ access_level_regex

          if scope_type == 'patient'
            granted_patient_level_resource_types << resource_type
          else
            granted_user_level_resource_types << resource_type
          end
        end

        # Check if the required patient and user level scopes are granted
        missing_patient_level_resource_types = patient_compartment_resource_types - granted_patient_level_resource_types
        missing_patient_level_resource_types = [] if granted_patient_level_resource_types.include?('*')

        assert missing_patient_level_resource_types.empty?,
               "Requested patient-level scopes #{missing_patient_level_resource_types.join(', ')} " \
                'were not granted by authorization server.'

        missing_user_level_resource_types = patient_compartment_resource_types - granted_user_level_resource_types
        missing_user_level_resource_types = [] if granted_user_level_resource_types.include?('*')
        assert missing_user_level_resource_types.empty?,
               "Requested user-level scopes #{missing_user_level_resource_types.join(', ')} " \
                'were not granted by authorization server.'
      end

      run do
        skip_if request.status != 200, 'Token exchange was unsuccessful'
        [
          {
            scopes: requested_scopes,
            received_or_requested: 'requested'
          },
          {
            scopes: received_scopes,
            received_or_requested: 'received'
          }
        ].each do |metadata|
          scopes = metadata[:scopes].split
          received_or_requested = metadata[:received_or_requested]
          missing_scopes = required_scopes - scopes

          if received_or_requested == 'requested'
            assert missing_scopes.empty?,
                   "Required scopes were not #{received_or_requested}: #{missing_scopes.join(', ')}"
          else
            received_scope_test(scopes)
          end
        end
      end
    end
  end
end
