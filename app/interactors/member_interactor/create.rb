module MemberInteractor
  class Create
    include Interactor

    before do
      context.params[:person] = Person.new(context.params[:person])
    end

    def call
      context.member = Member.create!(context.params)
    end
  end
end
