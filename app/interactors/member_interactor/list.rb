module MemberInteractor
  class List
    include Interactor::Presenter

    def call
      apply_list_configs(Member.all)
    end
  end
end
