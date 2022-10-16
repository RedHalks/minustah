module CashFlowInteractor
  class Create
    include Interactor

    def call
      context.cash_flow = CashFlow.create(context.params)

      context.fail! if context.cash_flow.errors.present?
    end
  end
end
