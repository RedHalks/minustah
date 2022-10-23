module Reports
  class InvoicesController < AuthenticatedController
    
    def paid
      @result = ReportInteractor::Invoices::Paid.call(year: Date.today.year)

      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "invoices", orientation: 'Landscape', layout: 'pdf', formats: [:html]
        end
      end
    end
  end
end
