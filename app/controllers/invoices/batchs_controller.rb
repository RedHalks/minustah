module Invoices
  class BatchsController < AuthenticatedController
    def new
      default_attr = {
        category: :membership,
        reference_date: Time.zone.today
      }
      @invoice = Invoice.new(default_attr)
    end

    def create
      params.require(:invoice).permit(:category, :reference_date).to_h

      Member.active.all.each do |member|
        invoice_params = permitted_params.merge({ member:, value: member.membership_value })

        Invoice.find_or_create_by(invoice_params)
      end

      redirect_to invoices_path
    end

    private

    def permitted_params
      params.require(:invoice).permit(:category, :reference_date).to_h
    end
  end
end
