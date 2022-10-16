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
FactoryBot.define do
  factory :invoice do
    category { Invoice.categories.values.sample }
    reference_month { Time.zone.today.month }
    reference_year { Time.zone.today.year }
    value { Faker::Number.decimal(r_digits: 2) }

    association :member
  end
end
