module ReportInteractor
  module CashFlows
    class Monthly
      include Interactor

      before do
        context.monthly_input = 0
        context.monthly_output = 0
        context.memberships = {}
      end

      def call
        context.past_balance = past_input - past_output
        calculate
        # calculate_monthly_input
        # calculate_monthly_output
      end

      protected

      def date
        Date.new(context.year.to_i, context.month.to_i, 1)
      end

      def past_input
        CashFlow.input.where('moved_at < ?', date).sum(:value)
      end

      def past_output
        CashFlow.output.where('moved_at < ?', date).sum(:value)
      end

      def calculate
        CashFlow.where('moved_at BETWEEN :begin and :end', begin: date, end: date.end_of_month).each do |cash_flow|
          context.monthly_input += cash_flow.value if cash_flow.input?
          context.monthly_output += cash_flow.value if cash_flow.output?
          build_membership(cash_flow) if cash_flow.membership?
        end
      end

      def build_membership(cash_flow)
        cash_flow.invoices.each do |invoice|
          key = "#{invoice.reference_month}/#{invoice.reference_year}"
          context.memberships[key] ||= 0
          context.memberships[key] += invoice.value
        end
      end

      # def calculate_monthly_input
      #   context.monthly_input = CashFlow.input
      #     .where('moved_at BETWEEN :begin and :end', begin: date, end: date.end_of_month)
      #     .sum(:value)
      # end

      # def calculate_monthly_output
      #   context.monthly_output = CashFlow.output
      #     .where('moved_at BETWEEN :begin and :end', begin: date, end: date.end_of_month)
      #     .sum(:value)
      # end
    end
  end
end
