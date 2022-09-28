module CashFlows
  module Kind
    extend ActiveSupport::Concern

    included do
      enum kind: {
        input: 'input',
        output: 'output'
      }
    end
  end
end
