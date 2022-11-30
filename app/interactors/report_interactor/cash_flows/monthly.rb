module ReportInteractor
  module CashFlows
    class Monthly
      include Interactor

      before do
        context.monthly_input = 0
        context.monthly_output = 0
        context.memberships = {}
        context.other_inputs = {}
        context.other_outputs = {}
      end

      def call
        context.past_balance = past_input - past_output
        calculate
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
        cash_flow_on_month.each do |cash_flow|
          if cash_flow.input?
            context.monthly_input += cash_flow.value
            cash_flow.membership? ? build_membership(cash_flow) : build_other_inputs(cash_flow)
          end
          if cash_flow.output?
            context.monthly_output += cash_flow.value
            build_other_outputs(cash_flow)
          end
        end
      end

      def cash_flow_on_month
        CashFlow.includes(:invoices)
                .where('moved_at BETWEEN :begin and :end', begin: date, end: date.end_of_month)
      end

      def build_membership(cash_flow)
        cash_flow.invoices.each do |invoice|
          key = "#{invoice.reference_date.year}-#{invoice.formated_reference_month}"
          context.memberships[key] ||= {
            label: "#{invoice.formated_reference_month}/#{invoice.reference_date.year}",
            value: 0
          }
          context.memberships[key][:value] += invoice.value
        end
      end

      def build_other_inputs(cash_flow)
        context.other_inputs[cash_flow.category] ||= 0
        context.other_inputs[cash_flow.category] += cash_flow.value
      end

      def build_other_outputs(cash_flow)
        context.other_outputs[cash_flow.category] ||= 0
        context.other_outputs[cash_flow.category] += cash_flow.value
      end
    end
  end
end
