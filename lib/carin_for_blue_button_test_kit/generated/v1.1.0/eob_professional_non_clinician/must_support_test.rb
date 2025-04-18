require_relative '../../../must_support_test'
require_relative './read_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV110
    class EobProfessionalNonClinicianMustSupportTest < Inferno::Test
      include CarinForBlueButtonTestKit::MustSupportTest
      include CarinForBlueButtonTestKit::CARIN4BBV110

      title 'All must support elements are provided in the ExplanationOfBenefitProfessionalNonClinician resources returned'
      description %(
        CARIN for Blue Button Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the CARIN for Blue Button Capability
        Statement. This test will look through the ExplanationOfBenefitProfessionalNonClinician resources
        found previously for the following must support elements:

                * ExplanationOfBenefit.billablePeriod
        * ExplanationOfBenefit.careTeam
        * ExplanationOfBenefit.careTeam.provider
        * ExplanationOfBenefit.careTeam.qualification
        * ExplanationOfBenefit.careTeam.role
        * ExplanationOfBenefit.diagnosis
        * ExplanationOfBenefit.diagnosis.diagnosis[x]
        * ExplanationOfBenefit.diagnosis.type
        * ExplanationOfBenefit.identifier
        * ExplanationOfBenefit.identifier.type
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
        * ExplanationOfBenefit.item.adjudication:allowedunits
        * ExplanationOfBenefit.item.adjudication:allowedunits.category
        * ExplanationOfBenefit.item.adjudication:benefitpaymentstatus
        * ExplanationOfBenefit.item.adjudication:benefitpaymentstatus.category
        * ExplanationOfBenefit.item.adjudication:denialreason
        * ExplanationOfBenefit.item.adjudication:denialreason.category
        * ExplanationOfBenefit.item.adjudication:denialreason.reason
        * ExplanationOfBenefit.item.modifier
        * ExplanationOfBenefit.item.noteNumber
        * ExplanationOfBenefit.item.productOrService
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
        * ExplanationOfBenefit.supportingInfo:billingnetworkcontractingstatus
        * ExplanationOfBenefit.supportingInfo:billingnetworkcontractingstatus.category
        * ExplanationOfBenefit.supportingInfo:billingnetworkcontractingstatus.code
        * ExplanationOfBenefit.supportingInfo:clmrecvddate
        * ExplanationOfBenefit.supportingInfo:clmrecvddate.category
        * ExplanationOfBenefit.supportingInfo:clmrecvddate.timing[x]
        * ExplanationOfBenefit.supportingInfo:medicalrecordnumber
        * ExplanationOfBenefit.supportingInfo:patientaccountnumber
        * ExplanationOfBenefit.supportingInfo:performingnetworkcontractingstatus
        * ExplanationOfBenefit.supportingInfo:performingnetworkcontractingstatus.category
        * ExplanationOfBenefit.supportingInfo:performingnetworkcontractingstatus.code
        * ExplanationOfBenefit.supportingInfo:servicefacility
        * ExplanationOfBenefit.supportingInfo:servicefacility.category
        * ExplanationOfBenefit.total
        * ExplanationOfBenefit.total.category
        * ExplanationOfBenefit.total:adjudicationamounttype
        * ExplanationOfBenefit.type.coding.code
        * ExplanationOfBenefit.use
      )

      id :c4bb_v110_eob_professional_non_clinician_must_support_test

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
