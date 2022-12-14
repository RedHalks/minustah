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
class Member < ApplicationRecord
  include Members::Kind
  include Members::State

  has_many :invoices, dependent: :restrict_with_exception
  belongs_to :person

  validates :kind, :state, presence: true

  accepts_nested_attributes_for :person

  default_scope { includes(:person) }

  def name
    nickname.presence || person.name
  end

  def membership_value
    official? ? 20 : 10
  end
end
