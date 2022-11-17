module Reports
  class InvoicesController < AuthenticatedController
    def paid
      @format = params[:format]
      @year = params.require(:year)
      @result = ReportInteractor::Invoices::Paid.call(year: params.require(:year))

      respond_to do |format|
        format.html
        format.pdf do
          render pdf: 'invoices_paid', orientation: 'Landscape', layout: 'pdf', formats: [:html]
        end
      end
    end
  end
end
