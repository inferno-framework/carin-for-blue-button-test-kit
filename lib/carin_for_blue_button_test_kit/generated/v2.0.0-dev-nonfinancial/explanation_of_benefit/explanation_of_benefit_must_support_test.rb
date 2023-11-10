require_relative '../../../must_support_test'
require_relative './explanation_of_benefit_read_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class ExplanationOfBenefitMustSupportTest < Inferno::Test
      include CarinForBlueButtonTestKit::MustSupportTest
      include CarinForBlueButtonTestKit::CARIN4BBV200DEVNONFINANCIAL

      title 'All must support elements are provided in the ExplanationOfBenefit resources returned'
      description %(
        CARIN for Blue Button Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the CARIN for Blue Button Capability
        Statement. This test will look through the ExplanationOfBenefit resources
        found previously for the following must support elements:

                * ExplanationOfBenefit.billablePeriod
        * ExplanationOfBenefit.billablePeriod.start
        * ExplanationOfBenefit.careTeam
        * ExplanationOfBenefit.careTeam.provider
        * ExplanationOfBenefit.careTeam.role
        * ExplanationOfBenefit.identifier.value
        * ExplanationOfBenefit.identifier:uniqueclaimid
        * ExplanationOfBenefit.insurance
        * ExplanationOfBenefit.insurance.coverage
        * ExplanationOfBenefit.insurance.focal
        * ExplanationOfBenefit.insurer
        * ExplanationOfBenefit.item
        * ExplanationOfBenefit.item.adjudication.category
        * ExplanationOfBenefit.item.noteNumber
        * ExplanationOfBenefit.item.sequence
        * ExplanationOfBenefit.meta
        * ExplanationOfBenefit.meta.lastUpdated
        * ExplanationOfBenefit.outcome
        * ExplanationOfBenefit.patient
        * ExplanationOfBenefit.payee
        * ExplanationOfBenefit.payee.party
        * ExplanationOfBenefit.payee.type
        * ExplanationOfBenefit.payment
        * ExplanationOfBenefit.payment.type
        * ExplanationOfBenefit.processNote
        * ExplanationOfBenefit.provider
        * ExplanationOfBenefit.related
        * ExplanationOfBenefit.related.reference
        * ExplanationOfBenefit.related.relationship
        * ExplanationOfBenefit.status
        * ExplanationOfBenefit.supportingInfo
        * ExplanationOfBenefit.type
        * ExplanationOfBenefit.use
      )

      id :c4bb_v200devnonfinancial_explanation_of_benefit_must_support_test

      def resource_type
        'ExplanationOfBenefit'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:explanation_of_benefit_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
