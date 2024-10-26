module CarinForBlueButtonTestKit
  SET_TO_BE_GATHERED = { Coverage: ['c4bb-Coverage'],
                         ExplanationOfBenefit: ['c4bb-EOBInpatient', 'c4bb-EOBOral', 'c4bb-EOBOutpatient',
                                                'c4bb-EOBPharmacy', 'c4bb-EOBProfessional'],
                         Organization: ['c4bb-Organization'],
                         Patient: ['998'],
                         Practitioner: ['c4bb-Practitioner'],
                         RelatedPerson: ['c4bb-RelatedPerson'] }.freeze

  SEARCHES_BY_PRIORITY = { Coverage: [['_id'], ['_lastUpdated']],
                           ExplanationOfBenefit: [['_id'], ['patient'], ['identifier'], ['_lastUpdated'],
                                                  ['service-date'], ['service-start-date'], ['billable-period-start'],
                                                  ['type']],
                           Organization: [['_id'], ['_lastUpdated']],
                           Patient: [['_id'], ['_lastUpdated']],
                           Practitioner: [['_id'], ['_lastUpdated']],
                           RelatedPerson: [['_id'], ['_lastUpdated']] }.freeze
end
