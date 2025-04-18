require_relative '../../../must_support_test'
require_relative './read_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class EobOutpatientInstitutionalNonFinancialMustSupportTest < Inferno::Test
      include CarinForBlueButtonTestKit::MustSupportTest
      include CarinForBlueButtonTestKit::CARIN4BBV200DEVNONFINANCIAL

      title 'All must support elements are provided in the ExplanationOfBenefit resources returned'
      description %(
        CARIN for Blue Button Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the CARIN for Blue Button Capability
        Statement. This test will look through the ExplanationOfBenefit resources
        found previously for the following must support elements:

                * ExplanationOfBenefit.adjudication
        * ExplanationOfBenefit.adjudication.category
        * ExplanationOfBenefit.adjudication:adjustmentreason
        * ExplanationOfBenefit.adjudication:adjustmentreason.reason
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
        * ExplanationOfBenefit.diagnosis.diagnosis[x]
        * ExplanationOfBenefit.diagnosis.type
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
        * ExplanationOfBenefit.item.adjudication:adjustmentreason
        * ExplanationOfBenefit.item.adjudication:adjustmentreason.category
        * ExplanationOfBenefit.item.adjudication:adjustmentreason.reason
        * ExplanationOfBenefit.item.adjudication:allowedunits
        * ExplanationOfBenefit.item.adjudication:allowedunits.category
        * ExplanationOfBenefit.item.adjudication:allowedunits.value
        * ExplanationOfBenefit.item.modifier
        * ExplanationOfBenefit.item.noteNumber
        * ExplanationOfBenefit.item.productOrService
        * ExplanationOfBenefit.item.quantity
        * ExplanationOfBenefit.item.revenue
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
        * ExplanationOfBenefit.subType.coding.code
        * ExplanationOfBenefit.supportingInfo
        * ExplanationOfBenefit.supportingInfo:admtype
        * ExplanationOfBenefit.supportingInfo:admtype.category
        * ExplanationOfBenefit.supportingInfo:admtype.code
        * ExplanationOfBenefit.supportingInfo:clmrecvddate
        * ExplanationOfBenefit.supportingInfo:clmrecvddate.category
        * ExplanationOfBenefit.supportingInfo:clmrecvddate.timing[x]
        * ExplanationOfBenefit.supportingInfo:discharge-status
        * ExplanationOfBenefit.supportingInfo:discharge-status.category
        * ExplanationOfBenefit.supportingInfo:discharge-status.code
        * ExplanationOfBenefit.supportingInfo:medicalrecordnumber
        * ExplanationOfBenefit.supportingInfo:patientaccountnumber
        * ExplanationOfBenefit.supportingInfo:pointoforigin
        * ExplanationOfBenefit.supportingInfo:pointoforigin.category
        * ExplanationOfBenefit.supportingInfo:pointoforigin.code
        * ExplanationOfBenefit.supportingInfo:typeofbill
        * ExplanationOfBenefit.supportingInfo:typeofbill.category
        * ExplanationOfBenefit.supportingInfo:typeofbill.code
        * ExplanationOfBenefit.type.coding.code
        * ExplanationOfBenefit.use
      )

      id :c4bb_v200devnonfinancial_eob_outpatient_institutional_non_financial_must_support_test

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
