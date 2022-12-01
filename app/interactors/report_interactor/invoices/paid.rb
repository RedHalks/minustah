module ReportInteractor
  module Invoices
    class Paid
      include Interactor

      def call
        context.invoices = Invoice.includes(:member)
                                  .membership.on_year(Date.new(context.year.to_i, 1, 1))
      end
    end
  end
end
