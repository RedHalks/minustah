# == Schema Information
#
# Table name: cash_flows
#
#  id          :bigint           not null, primary key
#  category    :string           not null
#  description :string
#  kind        :string           not null
#  moved_at    :date             not null
#  value       :float            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  member_id   :bigint
#
# Indexes
#
#  index_cash_flows_on_member_id  (member_id)
#
FactoryBot.define do
  factory :cash_flow do
    category { CashFlow.categories.values.sample }
    kind { CashFlow.kinds.values.sample }
    date { Time.zone.today }
    value { Faker::Number.decimal(r_digits: 2) }

    association :member
  end
end
