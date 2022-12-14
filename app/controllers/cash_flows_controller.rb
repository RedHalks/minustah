class CashFlowsController < AuthenticatedController
  before_action :find_cash_flow, only: %i[edit update destroy]

  def index
    params[:q] ||= {}
    params[:p] ||= {}
    params[:s] ||= ['date asc']

    @q = CashFlowInteractor::List.call(params.permit!).data
    @pagy, @cash_flows = pagy(@q.result)
  end

  def new
    @cash_flow = CashFlow.new
  end

  def create
    result = CashFlowInteractor::Create.call(params: permitted_params)

    if result.success?
      create_success_notice
      redirect_to cash_flows_path
    else
      @cash_flow = result.cash_flow
      build_error_alert
      render :new
    end
  end

  def edit; end

  def update
    result = CashFlowInteractor::Update.call(cash_flow: @cash_flow, params: permitted_params)

    if result.success?
      update_success_notice
      redirect_to cash_flows_path
    else
      @cash_flow = result.cash_flow
      build_error_alert
      render :edit
    end
  end

  def destroy
    @cash_flow.destroy ? delete_success_notice : build_error_alert

    redirect_to cash_flows_path
  end

  private

  def build_error_alert
    flash[:alert] = @cash_flow.errors.map(&:full_message)
  end

  def find_cash_flow
    @cash_flow = CashFlow.find(params[:id])
  end

  def permitted_params
    params.require(:cash_flow).permit(:category, :kind, :value, :member_id, :moved_at, :description).to_h
  end
end
