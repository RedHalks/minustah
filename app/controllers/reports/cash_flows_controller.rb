module Reports
  class CashFlowsController < AuthenticatedController
    def monthly
      @format = params[:format]
      @date = params.require(:date).to_date
      @result = ReportInteractor::CashFlows::Monthly.call(month: format('%02d', @date.month), year: @date.year)

      respond_to do |format|
        format.html
        format.pdf do
          render pdf: 'cash_flow_monthly', layout: @layout, formats: [:html]
        end
      end
    end
  end
end
