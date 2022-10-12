# == Schema Information
#
# Table name: cash_flows
#
#  id         :bigint           not null, primary key
#  category   :string           not null
#  date       :date             not null
#  kind       :string           not null
#  value      :float            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  member_id  :bigint
#
# Indexes
#
#  index_cash_flows_on_member_id  (member_id)
#
class CashFlow < ApplicationRecord
  include CashFlows::Kind
  include CashFlows::Category

  belongs_to :member

  validates :kind, :category, :value, presence: true
end
