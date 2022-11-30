module Members
  class InvoicesController < AuthenticatedController
    before_action :find_invoice, only: %i[edit update destroy]

    def index
      params[:q] ||= {}
      params[:p] ||= {}
      params[:s] ||= ['created_at desc']
      @member_id = params.require(:member_id).to_i

      @pagy, @invoices = pagy(Invoice.where(member_id: @member_id), items: 10)
      # InvoiceInteractor::List.call(params.permit!)
    end

    def new
      default_attr = {
        value: Member.find(params[:member_id]).membership_value,
        category: :membership,
        reference_date: Time.zone.today
      }.merge(params.permit(:member_id).to_h)

      @invoice = Invoice.new(default_attr)
    end

    def create
      result = InvoiceInteractor::Create.call(params: permitted_params)

      if result.success?
        create_success_notice
        redirect_to member_invoices_path(member_id: result.invoice.member_id)
      else
        @invoice = result.invoice
        build_error_alert
        render :new
      end
    end

    def edit; end

    def update
      result = InvoiceInteractor::Update.call(invoice: @invoice, params: permitted_params)

      if result.success?
        update_success_notice
        redirect_to member_invoices_path(member_id: result.invoice.member_id)
      else
        @invoice = result.invoice
        build_error_alert
        render :edit
      end
    end

    def destroy
      @invoice.destroy ? delete_success_notice : build_error_alert

      redirect_to invoices_path
    end

    private

    def build_error_alert
      flash[:alert] = @invoice.errors.map(&:full_message)
    end

    def find_invoice
      @invoice = Invoice.find(params[:id])
    end

    def permitted_params
      params.require(:invoice).permit(:category, :value, :reference_date, :cash_flow_id,
                                      :member_id).to_h
    end
  end
end
