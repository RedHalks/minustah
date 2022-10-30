class MembersController < AuthenticatedController
  before_action :find_member, only: %i[edit update]

  def index
    params[:q] ||= {}
    params[:p] ||= {}
    params[:s] ||= ['person_name asc']

    @q = MemberInteractor::List.call(params.permit!).data
    @pagy, @members = pagy(@q.result)
  end

  def new
    @member = Member.new
  end

  def create
    result = MemberInteractor::Create.call(params: permitted_params)

    if result.success?
      create_success_notice
      redirect_to members_path
    else
      @member = result.member
      flash[:alert] = @member.errors.map(&:full_message)
      render :new
    end
  end

  def edit; end

  def update
    result = MemberInteractor::Update.call(member: @member, params: permitted_params)

    if result.success?
      update_success_notice
      redirect_to members_path
    else
      @member = result.member
      flash[:alert] = @member.errors.map(&:full_message)
      render :edit
    end
  end

  private

  def find_member
    @member = Member.find(params[:id])
  end

  def permitted_params
    params.require(:member).permit(:nickname, :kind, :state, person_attributes: %i[name birthdate blood_type]).to_h
  end
end
