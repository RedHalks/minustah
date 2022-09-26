# == Schema Information
#
# Table name: members
#
#  id         :bigint           not null, primary key
#  kind       :string           not null
#  nickname   :string
#  state      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :bigint
#
# Indexes
#
#  index_members_on_person_id  (person_id)
#
FactoryBot.define do
  factory :member do
    nickname { Faker::FunnyName.name }
    kind { Member.kinds.values.sample }
    state { 'active' }

    association :person
  end
end
