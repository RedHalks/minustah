module MemberInteractor
  class Create
    include Interactor

    before do
      context.params[:person] = Person.new(context.params[:person])
    end

    def call
      context.member = Member.create(context.params)

      context.fail!(message: 'Error') if context.member.errors.present?
    end
  end
end
