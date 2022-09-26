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
class Person < ApplicationRecord
  include People::BloodType

  validates :name, presence: true
end
