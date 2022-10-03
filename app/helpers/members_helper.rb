module MembersHelper
  def member_kind_options
    Member.kinds.keys.map do |key|
      [Member.human_attribute_name("kind.#{ key }"), key]
    end
  end
  def member_state_options
    Member.states.keys.map do |key|
      [Member.human_attribute_name("state.#{ key }"), key]
    end
  end
end
