# == Schema Information
#
# Table name: invoices
#
#  id              :bigint           not null, primary key
#  category        :string           not null
#  reference_date  :date
#  reference_month :integer
#  reference_year  :integer
#  value           :float            not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  cash_flow_id    :bigint
#  member_id       :bigint
#
# Indexes
#
#  index_invoices_on_cash_flow_id  (cash_flow_id)
#  index_invoices_on_member_id     (member_id)
#  index_invoices_once_per_month   (member_id,reference_month,reference_year) UNIQUE
#
class Invoice < ApplicationRecord
  include Invoices::Category

  belongs_to :member
  belongs_to :cash_flow, optional: true

  validates :category, :value, :reference_date, presence: true

  scope :paid, -> { where('cash_flow_id IS NOT NULL') }
  scope :on_month, lambda { |date = Time.zone.today|
    where('reference_date BETWEEN :begin AND :end', begin: date.beginning_of_month, end: date.end_of_month)
  }
  scope :on_year, lambda { |date = Time.zone.today|
    where('reference_date BETWEEN :begin AND :end', begin: date.beginning_of_year, end: date.end_of_year)
  }
  scope :overdue, lambda {
    where(cash_flow_id: nil)
      .where('reference_date < :date', date: Time.zone.today.beginning_of_month)
  }

  def paid?
    cash_flow_id.present?
  end

  def formated_reference_month
    format('%02d', reference_date.month)
  end
end
