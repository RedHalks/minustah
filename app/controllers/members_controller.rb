class MembersController < ApplicationController
  before_action :find_member, only: [:edit, :update, :delete]

  def index
    params[:q] ||= {}
    params[:p] ||= {}
    params[:s] ||= ['person_name asc']

    @pagy, @members = pagy(Member.all, items: 10)
    # MemberInteractor::List.call(params.permit!)
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

  def edit;end

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

  def fetch_employee
    HumanResources::EmployeeService::Fetch.call(params[:id])
  end
  def permitted_params
    params.require(:member).permit(:nickname, :kind, :state, person_attributes: %i[name birthdate blood_type]).to_h
  end
end
