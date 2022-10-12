module InvoiceInteractor
  class Update
    include Interactor

    def call
      context.invoice.update(context.params)

      context.fail!(message: 'Error') if context.invoice.errors.present?
    end
  end
end
