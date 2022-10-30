module InvoiceInteractor
  class List
    include Interactor::Presenter

    def call
      context.data = apply_list_configs(Invoice.includes(:member).all)
    end
  end
end
