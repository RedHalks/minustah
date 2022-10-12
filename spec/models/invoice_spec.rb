require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:reference_month) }
    it { is_expected.to validate_presence_of(:reference_year) }
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:value) }
  end

  describe 'enums' do
    let(:category) do
      {
        membership: 'membership'
      }
    end

    it { is_expected.to define_enum_for(:category).with_values(category).backed_by_column_of_type(:string) }
  end

  describe 'factories' do
    it { expect(build(:invoice)).to be_valid }
  end
end
