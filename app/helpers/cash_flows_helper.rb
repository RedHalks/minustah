module CashFlowsHelper
  def cash_flow_kind_options
    CashFlow.kinds.keys.map do |key|
      [CashFlow.human_attribute_name("kind.#{key}"), key]
    end
  end

  def cash_flow_category_options
    CashFlow.categories.keys.map do |key|
      [CashFlow.human_attribute_name("category.#{key}"), key]
    end
  end

  def cash_flow_members
    Member.active.map { |member| [member.name, member.id] }
  end
end
