module CashFlowInteractor
  class Create
    include Interactor

    def call
      context.cash_flow = CashFlow.create!(context.params)
    end
  end
end
