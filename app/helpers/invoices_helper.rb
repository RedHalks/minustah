module InvoicesHelper
  def invoice_cash_flows(member_id)
    CashFlow.input.membership.where(member_id:).map do |cash_flow|
      ["#{l(cash_flow.moved_at, format: :long)} - R$ #{cash_flow.value.to_f.round(2)}", cash_flow.id]
    end
  end

  def invoice_members
    Member.active.map { |member| [member.name, member.id] }
  end

  def invoice_category_options
    Invoice.categories.keys.map do |key|
      [Invoice.human_attribute_name("category.#{key}"), key]
    end
  end
end
