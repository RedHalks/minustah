module MemberInteractor
  class Create
    include Interactor

    def call
      context.member = Member.create(context.params)

      context.fail!(message: 'Error') if context.member.errors.present?
    end
  end
end
