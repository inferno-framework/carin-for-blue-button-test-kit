require_relative '../../../must_support_test'
require_relative './explanation_of_benefit_oral_read_test'
require_relative '../../../generator/group_metadata'

module CARINForBlueButton
  module CARIN4BBV120
    class ExplanationOfBenefitOralMustSupportTest < Inferno::Test
      include CARINForBlueButton::MustSupportTest
      include CARINForBlueButton::CARIN4BBV120

      title 'All must support elements are provided in the ExplanationOfBenefit resources returned'
      description %(
        CARIN for Blue Button Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the CARIN for Blue Button Capability
        Statement. This test will look through the ExplanationOfBenefit resources
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
        * ExplanationOfBenefit.item.adjudication.amount
        * ExplanationOfBenefit.item.adjudication.category
        * ExplanationOfBenefit.item.adjudication.category.coding.code
        * ExplanationOfBenefit.item.adjudication.reason
        * ExplanationOfBenefit.item.adjudication:adjudicationamounttype
        * ExplanationOfBenefit.item.adjudication:allowedunits
        * ExplanationOfBenefit.item.adjudication:benefitpaymentstatus
        * ExplanationOfBenefit.item.adjudication:denialreason
        * ExplanationOfBenefit.item.informationSequence
        * ExplanationOfBenefit.item.location[x]
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
        * ExplanationOfBenefit.supportingInfo.category.coding.code
        * ExplanationOfBenefit.supportingInfo.code
        * ExplanationOfBenefit.supportingInfo.timing[x]
        * ExplanationOfBenefit.supportingInfo.value[x]
        * ExplanationOfBenefit.supportingInfo:additionalbodysite
        * ExplanationOfBenefit.supportingInfo:benefitpaymentstatus
        * ExplanationOfBenefit.supportingInfo:billingnetworkcontractingstatus
        * ExplanationOfBenefit.supportingInfo:clmrecvddate
        * ExplanationOfBenefit.supportingInfo:medicalrecordnumber
        * ExplanationOfBenefit.supportingInfo:missingtoothnumber
        * ExplanationOfBenefit.supportingInfo:orthodontics
        * ExplanationOfBenefit.supportingInfo:patientaccountnumber
        * ExplanationOfBenefit.supportingInfo:performingnetworkcontractingstatus
        * ExplanationOfBenefit.supportingInfo:prosthesis
        * ExplanationOfBenefit.supportingInfo:servicefacility
        * ExplanationOfBenefit.total
        * ExplanationOfBenefit.total.category
        * ExplanationOfBenefit.total:adjudicationamounttype
        * ExplanationOfBenefit.type.coding.code
        * ExplanationOfBenefit.use
      )

      id :c4bb_v120_explanation_of_benefit_oral_must_support_test

      def resource_type
        'ExplanationOfBenefit'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:explanation_of_benefit_oral_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
