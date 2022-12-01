# == Schema Information
#
# Table name: cash_flows
#
#  id         :bigint           not null, primary key
#  category   :string           not null
#  kind       :string           not null
#  moved_at   :date             not null
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

  has_many :invoices, dependent: :restrict_with_exception

  validates :kind, :category, :value, presence: true

  scope :invoiced, -> { not_donation.not_revenue }

  def self.balance
    input.sum(:value) - output.sum(:value)
  end
end
