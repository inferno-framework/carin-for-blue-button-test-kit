require_relative '../../../must_support_test'
require_relative './explanation_of_benefit_inpatient_institutional_read_test'
require_relative '../../../generator/group_metadata'

module CARINForBlueButton
  module CARIN4BBV200
    class ExplanationOfBenefitInpatientInstitutionalMustSupportTest < Inferno::Test
      include CARINForBlueButton::MustSupportTest
      include CARINForBlueButton::CARIN4BBV200

      title 'All must support elements are provided in the ExplanationOfBenefit resources returned'
      description %(
        CARIN for Blue Button Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the CARIN for Blue Button Capability
        Statement. This test will look through the ExplanationOfBenefit resources
        found previously for the following must support elements:

        * ExplanationOfBenefit.adjudication
        * ExplanationOfBenefit.adjudication.category
        * ExplanationOfBenefit.adjudication.reason
        * ExplanationOfBenefit.adjudication:adjudicationamounttype
        * ExplanationOfBenefit.adjudication:adjustmentreason
        * ExplanationOfBenefit.adjudication:benefitpaymentstatus
        * ExplanationOfBenefit.adjudication:billingnetworkstatus
        * ExplanationOfBenefit.billablePeriod
        * ExplanationOfBenefit.billablePeriod.end
        * ExplanationOfBenefit.billablePeriod.start
        * ExplanationOfBenefit.careTeam
        * ExplanationOfBenefit.careTeam.provider
        * ExplanationOfBenefit.careTeam.role
        * ExplanationOfBenefit.created
        * ExplanationOfBenefit.diagnosis
        * ExplanationOfBenefit.diagnosis.diagnosis[x]
        * ExplanationOfBenefit.diagnosis.onAdmission
        * ExplanationOfBenefit.diagnosis.type
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
        * ExplanationOfBenefit.item.adjudication.value
        * ExplanationOfBenefit.item.adjudication:adjudicationamounttype
        * ExplanationOfBenefit.item.adjudication:adjustmentreason
        * ExplanationOfBenefit.item.adjudication:allowedunits
        * ExplanationOfBenefit.item.modifier
        * ExplanationOfBenefit.item.noteNumber
        * ExplanationOfBenefit.item.productOrService
        * ExplanationOfBenefit.item.quantity
        * ExplanationOfBenefit.item.revenue
        * ExplanationOfBenefit.item.sequence
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
        * ExplanationOfBenefit.procedure
        * ExplanationOfBenefit.procedure.date
        * ExplanationOfBenefit.procedure.procedure[x]
        * ExplanationOfBenefit.procedure.type
        * ExplanationOfBenefit.processNote
        * ExplanationOfBenefit.processNote.text
        * ExplanationOfBenefit.provider
        * ExplanationOfBenefit.related
        * ExplanationOfBenefit.related.reference
        * ExplanationOfBenefit.related.relationship
        * ExplanationOfBenefit.status
        * ExplanationOfBenefit.subType.coding.code
        * ExplanationOfBenefit.supportingInfo
        * ExplanationOfBenefit.supportingInfo.category.coding.code
        * ExplanationOfBenefit.supportingInfo.code
        * ExplanationOfBenefit.supportingInfo.timing[x]
        * ExplanationOfBenefit.supportingInfo:admissionperiod
        * ExplanationOfBenefit.supportingInfo:admtype
        * ExplanationOfBenefit.supportingInfo:clmrecvddate
        * ExplanationOfBenefit.supportingInfo:discharge-status
        * ExplanationOfBenefit.supportingInfo:drg
        * ExplanationOfBenefit.supportingInfo:medicalrecordnumber
        * ExplanationOfBenefit.supportingInfo:patientaccountnumber
        * ExplanationOfBenefit.supportingInfo:pointoforigin
        * ExplanationOfBenefit.supportingInfo:typeofbill
        * ExplanationOfBenefit.total
        * ExplanationOfBenefit.total.amount
        * ExplanationOfBenefit.total.category
        * ExplanationOfBenefit.total:adjudicationamounttype
        * ExplanationOfBenefit.type.coding.code
        * ExplanationOfBenefit.use
      )

      id :c4bb_v200_explanation_of_benefit_inpatient_institutional_must_support_test

      #uses_request :explanation_of_benefit_inpatient_institutional_request

      def resource_type
        'ExplanationOfBenefit'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:explanation_of_benefit_inpatient_institutional_resources] ||= {}
      end

      def explanation_of_benefit_inpatient_institutional_resource
        CARIN4BBV200::ExplanationOfBenefitInpatientInstitutionalReadTest.new().explanation_of_benefit_inpatient_institutional_resource
      end 

      run do
        perform_must_support_test([explanation_of_benefit_inpatient_institutional_resource])
      end
    end
  end
end
