# == Schema Information
#
# Table name: people
#
#  id         :bigint           not null, primary key
#  birthdate  :date
#  blood_type :string
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :person do
    name { Faker::Name.name }
    birthdate { Faker::Date.birthday(min_age: 18, max_age: 65) }
    blood_type { Person.blood_types.values.sample }
  end
end
