module InvoiceInteractor
  class Create
    include Interactor

    def call
      context.invoice = Invoice.create(context.params)

      context.fail! if context.invoice.errors.present?
    end
  end
end
