require_relative './tests/instantiates_test'

module CARINForBlueButton
    class CapabilityStatmentGroup < Inferno::TestGroup
      title 'Capability Statement Tests'
      id :capability_statement_group
      description %(
        This test group inspects the CapabilityStatement returned by the server.
      )

      test from: :carin_bb_instantiate
    end
end