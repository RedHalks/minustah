module CashFlowInteractor
  class Update
    include Interactor

    def call
      context.cash_flow.update(context.params)

      context.fail!(message: 'Error') if context.cash_flow.errors.present?
    end
  end
end
