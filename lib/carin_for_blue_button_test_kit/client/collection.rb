module CarinForBlueButtonTestKit
  SET_TO_BE_GATHERED = { Coverage: ['c4bb-Coverage'],
                         ExplanationOfBenefit: ['c4bb-EOB-Inpatient', 'c4bb-EOB-Oral', 'c4bb-EOB-Outpatient',
                                                'c4bb-EOB-Pharmacy', 'c4bb-EOB-Professional-NonClinician'],
                         Organization: ['c4bb-Organization'],
                         Patient: ['998'],
                         Practitioner: ['c4bb-Practitioner'],
                         RelatedPerson: ['c4bb-RelatedPerson'] }.freeze
  # TODO: What about Provenance?

  SEARCHES_BY_PRIORITY = { Coverage: [['_id'], ['_lastUpdated']],
                           ExplanationOfBenefit: [['_id'], ['patient'], ['identifier'], ['_lastUpdated'],
                                                  ['service-date'], ['service-start-date'], ['billable-period-start'],
                                                  ['type']],
                           Organization: [['_id'], ['_lastUpdated']],
                           Patient: [['_id'], ['_lastUpdated']],
                           Practitioner: [['_id'], ['_lastUpdated']],
                           RelatedPerson: [['_id'], ['_lastUpdated']] }.freeze
end
