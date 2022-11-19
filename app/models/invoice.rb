# == Schema Information
#
# Table name: invoices
#
#  id              :bigint           not null, primary key
#  category        :string           not null
#  reference_month :integer          not null
#  reference_year  :integer          not null
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

  validates :reference_month, :reference_year, numericality: { only_integer: true }
  validates :reference_month, numericality: { in: 1..12 }
  validates :reference_year, numericality: { greater_than_or_equal_to: 2022 }
  validates :member_id, uniqueness: { scope: %i[reference_month reference_year],
                                      message: 'should happen once per month' }

  validates :category, :value, :reference_month, :reference_year, presence: true

  scope :paid, -> { where('cash_flow_id IS NOT NULL') }
  scope :on_month, lambda { |month = Time.zone.today.month, year = Time.zone.today.year|
    where(reference_month: month, reference_year: year)
  }
  scope :overdue, lambda {
    where(cash_flow_id: nil)
      .where('reference_month < :month AND invoices.reference_year = :year OR invoices.reference_year > :year',
             month: Time.zone.today.month, year: Time.zone.today.year)
  }

  def paid?
    cash_flow_id.present?
  end

  def formated_reference_month
    format('%02d', reference_month)
  end
end
