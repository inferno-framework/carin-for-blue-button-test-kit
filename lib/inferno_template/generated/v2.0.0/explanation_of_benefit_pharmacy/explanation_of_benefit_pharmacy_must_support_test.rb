require_relative '../../../must_support_test'
require_relative './explanation_of_benefit_pharmacy_read_test'
require_relative '../../../generator/group_metadata'

module InfernoTemplate
  module CARIN4BBV200
    class ExplanationOfBenefitPharmacyMustSupportTest < Inferno::Test
      include InfernoTemplate::MustSupportTest
      include InfernoTemplate::CARIN4BBV200

      title 'All must support elements are provided in the ExplanationOfBenefit resources returned'
      description %(
        CARIN for Blue Button Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the CARIN for Blue Button Capability
        Statement. This test will look through the ExplanationOfBenefit resources
        found previously for the following must support elements:

        * ExplanationOfBenefit.adjudication
        * ExplanationOfBenefit.adjudication.category
        * ExplanationOfBenefit.adjudication.reason
        * ExplanationOfBenefit.adjudication:benefitpaymentstatus
        * ExplanationOfBenefit.adjudication:billingnetworkstatus
        * ExplanationOfBenefit.billablePeriod
        * ExplanationOfBenefit.billablePeriod.start
        * ExplanationOfBenefit.careTeam
        * ExplanationOfBenefit.careTeam.provider
        * ExplanationOfBenefit.careTeam.role
        * ExplanationOfBenefit.created
        * ExplanationOfBenefit.identifier
        * ExplanationOfBenefit.identifier.value
        * ExplanationOfBenefit.identifier:uniqueclaimid
        * ExplanationOfBenefit.insurance
        * ExplanationOfBenefit.insurance.coverage
        * ExplanationOfBenefit.insurance.focal
        * ExplanationOfBenefit.insurer
        * ExplanationOfBenefit.item
        * ExplanationOfBenefit.item.adjudication
        * ExplanationOfBenefit.item.adjudication.amount
        * ExplanationOfBenefit.item.adjudication.category
        * ExplanationOfBenefit.item.adjudication.category.coding.code
        * ExplanationOfBenefit.item.adjudication.reason
        * ExplanationOfBenefit.item.adjudication:adjudicationamounttype
        * ExplanationOfBenefit.item.adjudication:rejectreason
        * ExplanationOfBenefit.item.detail
        * ExplanationOfBenefit.item.detail.productOrService
        * ExplanationOfBenefit.item.detail.quantity
        * ExplanationOfBenefit.item.noteNumber
        * ExplanationOfBenefit.item.productOrService
        * ExplanationOfBenefit.item.quantity
        * ExplanationOfBenefit.item.sequence
        * ExplanationOfBenefit.item.serviced[x]:servicedDate
        * ExplanationOfBenefit.meta
        * ExplanationOfBenefit.meta.lastUpdated
        * ExplanationOfBenefit.outcome
        * ExplanationOfBenefit.patient
        * ExplanationOfBenefit.payee
        * ExplanationOfBenefit.payee.party
        * ExplanationOfBenefit.payee.type
        * ExplanationOfBenefit.payment
        * ExplanationOfBenefit.payment.date
        * ExplanationOfBenefit.payment.type
        * ExplanationOfBenefit.processNote
        * ExplanationOfBenefit.processNote.text
        * ExplanationOfBenefit.provider
        * ExplanationOfBenefit.related
        * ExplanationOfBenefit.related.reference
        * ExplanationOfBenefit.related.relationship
        * ExplanationOfBenefit.status
        * ExplanationOfBenefit.supportingInfo
        * ExplanationOfBenefit.supportingInfo.category.coding.code
        * ExplanationOfBenefit.supportingInfo.code
        * ExplanationOfBenefit.supportingInfo.timing[x]
        * ExplanationOfBenefit.supportingInfo.value[x]
        * ExplanationOfBenefit.supportingInfo:brandgenericindicator
        * ExplanationOfBenefit.supportingInfo:clmrecvddate
        * ExplanationOfBenefit.supportingInfo:compoundcode
        * ExplanationOfBenefit.supportingInfo:dawcode
        * ExplanationOfBenefit.supportingInfo:dayssupply
        * ExplanationOfBenefit.supportingInfo:refillNum
        * ExplanationOfBenefit.supportingInfo:refillsAuthorized
        * ExplanationOfBenefit.supportingInfo:rxoriginCode
        * ExplanationOfBenefit.total
        * ExplanationOfBenefit.total.amount
        * ExplanationOfBenefit.total.category
        * ExplanationOfBenefit.total:adjudicationamounttype
        * ExplanationOfBenefit.type.coding.code
        * ExplanationOfBenefit.use
      )

      id :c4bb_v200_explanation_of_benefit_pharmacy_must_support_test

      #uses_request :explanation_of_benefit_pharmacy_request

      def resource_type
        'ExplanationOfBenefit'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:explanation_of_benefit_pharmacy_resources] ||= {}
      end

      def explanation_of_benefit_pharmacy_resource
        CARIN4BBV200::ExplanationOfBenefitPharmacyReadTest.new().explanation_of_benefit_pharmacy_resource
      end 

      run do
        perform_must_support_test([explanation_of_benefit_pharmacy_resource])
      end
    end
  end
end
