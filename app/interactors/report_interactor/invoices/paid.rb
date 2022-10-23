module ReportInteractor
  module Invoices
    class Paid
      include Interactor

      def call
        context.invoices = Invoice.includes(:member).where(reference_year: context.year)
      end
    end
  end
end
