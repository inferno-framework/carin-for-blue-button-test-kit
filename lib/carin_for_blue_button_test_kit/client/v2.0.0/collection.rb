# frozen_string_literal: true

module CarinForBlueButtonTestKit
  SET_TO_BE_GATHERED = { Coverage: ['c4bb-Coverage'],
                         ExplanationOfBenefit: %w[c4bb-EOBInpatient c4bb-EOBOral c4bb-EOBOutpatient
                                                  c4bb-EOBPharmacy c4bb-EOBProfessional],
                         Organization: ['c4bb-Organization'],
                         Patient: ['888'],
                         Practitioner: ['c4bb-Practitioner'],
                         RelatedPerson: ['c4bb-RelatedPerson'] }.freeze

  SEARCHES_BY_PRIORITY = { Coverage: [['_id'], ['_lastUpdated'], ['patient']],
                           ExplanationOfBenefit: [['_id'], ['patient'], ['identifier'], ['_lastUpdated'],
                                                  ['service-date'], ['service-start-date'], ['billable-period-start'],
                                                  ['type'], ['_include']],
                           Organization: [['_id'], ['_lastUpdated'], ['name'], ['address']],
                           Patient: [['_id'], ['_lastUpdated'], ['birthdate'], ['family'], ['gender'], ['given'],
                                     ['identifier'], ['name']],
                           Practitioner: [['_id'], ['_lastUpdated'], ['name'], ['identifier']],
                           RelatedPerson: [['_id'], ['_lastUpdated'], ['patient']] }.freeze
end
