module Invoices
  class BatchsController < AuthenticatedController
    def new
      default_attr = {
        category: :membership,
        reference_month: Time.zone.today.month,
        reference_year: Time.zone.today.year
      }
      @invoice = Invoice.new(default_attr)
    end

    def create
      params.require(:invoice).permit(:category, :reference_month, :reference_year).to_h

      Member.active.all.each do |member|
        invoice_params = permitted_params.merge({ member:, value: member.membership_value })

        Invoice.find_or_create_by(invoice_params)
      end

      redirect_to invoices_path
    end

    private

    def permitted_params
      params.require(:invoice).permit(:category, :reference_month, :reference_year).to_h
    end
  end
end
