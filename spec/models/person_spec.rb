require 'rails_helper'

describe Person, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'enums' do
    let(:blood_type) do
      {
        a_plus: 'A+',
        a_minus: 'A-',
        b_plus: 'B+',
        b_minus: 'B-',
        o_plus: 'O+',
        o_minus: 'O-',
        ab_plus: 'AB+',
        ab_minus: 'AB-'
      }
    end

    it { is_expected.to define_enum_for(:blood_type).with_values(blood_type).backed_by_column_of_type(:string) }
  end

  describe 'factories' do
    it { expect(build(:person)).to be_valid }
  end
end
