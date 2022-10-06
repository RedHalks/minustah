module MemberInteractor
  class Update
    include Interactor

    before do
      context.params[:person_attributes][:id] = context.member.person.id
    end

    def call
      context.member.update(context.params)

      context.fail!(message: 'Error') if context.member.errors.present?
    end
  end
end
