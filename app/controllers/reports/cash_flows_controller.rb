module Reports
  class CashFlowsController < AuthenticatedController
    def monthly
      @result = ReportInteractor::CashFlows::Monthly.call(month: Time.zone.today.month,year: Time.zone.today.year)

      respond_to do |format|
        format.html
        format.pdf do
          render pdf: 'cash_flow_monthly', layout: 'pdf', formats: [:html]
        end
      end
    end
  end
end
