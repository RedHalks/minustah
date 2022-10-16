module CashFlowInteractor
  class List
    include Interactor::Presenter

    def call
      apply_list_configs(CashFlow.all)
    end
  end
end
