require_relative '../../../must_support_test'
require_relative './read_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class EobPharmacyMustSupportTest < Inferno::Test
      include CarinForBlueButtonTestKit::MustSupportTest
      include CarinForBlueButtonTestKit::CARIN4BBV200DEVNONFINANCIAL

      title 'All must support elements are provided in the ExplanationOfBenefitPharmacy resources returned'
      description %(
        CARIN for Blue Button Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the CARIN for Blue Button Capability
        Statement. This test will look through the ExplanationOfBenefitPharmacy resources
        found previously for the following must support elements:

                * ExplanationOfBenefit.adjudication
        * ExplanationOfBenefit.adjudication.category
        * ExplanationOfBenefit.adjudication:benefitpaymentstatus
        * ExplanationOfBenefit.adjudication:benefitpaymentstatus.reason
        * ExplanationOfBenefit.adjudication:billingnetworkstatus
        * ExplanationOfBenefit.adjudication:billingnetworkstatus.reason
        * ExplanationOfBenefit.billablePeriod
        * ExplanationOfBenefit.billablePeriod.start
        * ExplanationOfBenefit.careTeam
        * ExplanationOfBenefit.careTeam.provider
        * ExplanationOfBenefit.careTeam.role
        * ExplanationOfBenefit.created
        * ExplanationOfBenefit.identifier
        * ExplanationOfBenefit.identifier:uniqueclaimid
        * ExplanationOfBenefit.identifier:uniqueclaimid.value
        * ExplanationOfBenefit.insurance
        * ExplanationOfBenefit.insurance.coverage
        * ExplanationOfBenefit.insurance.focal
        * ExplanationOfBenefit.insurer
        * ExplanationOfBenefit.item
        * ExplanationOfBenefit.item.adjudication
        * ExplanationOfBenefit.item.adjudication.category
        * ExplanationOfBenefit.item.adjudication:adjudicationamounttype
        * ExplanationOfBenefit.item.adjudication:adjudicationamounttype.amount
        * ExplanationOfBenefit.item.adjudication:adjudicationamounttype.category
        * ExplanationOfBenefit.item.adjudication:rejectreason
        * ExplanationOfBenefit.item.adjudication:rejectreason.category
        * ExplanationOfBenefit.item.adjudication:rejectreason.reason
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
        * ExplanationOfBenefit.supportingInfo:brandgenericindicator
        * ExplanationOfBenefit.supportingInfo:brandgenericindicator.category
        * ExplanationOfBenefit.supportingInfo:brandgenericindicator.code
        * ExplanationOfBenefit.supportingInfo:clmrecvddate
        * ExplanationOfBenefit.supportingInfo:clmrecvddate.category
        * ExplanationOfBenefit.supportingInfo:clmrecvddate.timing[x]
        * ExplanationOfBenefit.supportingInfo:compoundcode
        * ExplanationOfBenefit.supportingInfo:compoundcode.category
        * ExplanationOfBenefit.supportingInfo:compoundcode.code
        * ExplanationOfBenefit.supportingInfo:dawcode
        * ExplanationOfBenefit.supportingInfo:dawcode.category
        * ExplanationOfBenefit.supportingInfo:dawcode.code
        * ExplanationOfBenefit.supportingInfo:dayssupply
        * ExplanationOfBenefit.supportingInfo:dayssupply.category
        * ExplanationOfBenefit.supportingInfo:dayssupply.value[x]
        * ExplanationOfBenefit.supportingInfo:refillNum
        * ExplanationOfBenefit.supportingInfo:refillNum.category
        * ExplanationOfBenefit.supportingInfo:refillNum.value[x]
        * ExplanationOfBenefit.supportingInfo:refillsAuthorized
        * ExplanationOfBenefit.supportingInfo:refillsAuthorized.category
        * ExplanationOfBenefit.supportingInfo:refillsAuthorized.value[x]
        * ExplanationOfBenefit.supportingInfo:rxoriginCode
        * ExplanationOfBenefit.supportingInfo:rxoriginCode.category
        * ExplanationOfBenefit.supportingInfo:rxoriginCode.code
        * ExplanationOfBenefit.total
        * ExplanationOfBenefit.total.amount
        * ExplanationOfBenefit.total.category
        * ExplanationOfBenefit.total:adjudicationamounttype
        * ExplanationOfBenefit.type.coding.code
        * ExplanationOfBenefit.use
      )
      verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@11'

      id :c4bb_v200devnonfinancial_eob_pharmacy_must_support_test

      def resource_type
        'ExplanationOfBenefit'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:explanationofbenefit_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
