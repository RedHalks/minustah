module MemberInteractor
  class List
    include Interactor::Presenter

    def call
      context.data = apply_list_configs(Member.all)
    end
  end
end
