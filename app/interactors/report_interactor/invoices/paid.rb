module ReportInteractor
  module Invoices
    class Paid
      include Interactor

      def call
        invoices_per_year.each do |invoice|
          member_key = invoice.member_id.to_s
          month_key = invoice.reference_month.to_s

          context.values ||= {}
          context.values[member_key] ||= {}
          context.values[member_key][month_key] ||= {}
          context.values[member_key][month_key][:value] = invoice.value
          context.values[member_key][month_key][:paid] = invoice.paid?

          if invoice.paid?
            context.total ||= {}
            context.total[month_key] ||= 0
            context.total[month_key] += invoice.value
            context.total[:year] ||= 0
            context.total[:year] += invoice.value
          end
        end
        context.invoices = invoices_per_year
      end

      protected

      def invoices_per_year
        Invoice.includes(:member)
               .where(reference_year: context.year)
      end
    end
  end
end
