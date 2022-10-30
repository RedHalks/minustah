module CashFlowInteractor
  class List
    include Interactor::Presenter

    def call
      context.data = apply_list_configs(CashFlow.includes(:member).all)
    end
  end
end
