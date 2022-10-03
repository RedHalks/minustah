class MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def new
    @member = Member.new
  end

  def create
    result = MemberInteractor::Create.call(params: permitted_params)

    if result.success?
      success_notice
      redirect_to members_path
    else
      @member = result.member
      flash[:alert] = result.message
      render :new
    end
  end

  private

  def permitted_params
    params.require(:member).permit(:nickname, :kind, :state, person: [:name, :birthdate, :blood_type]).to_h
  end
end
