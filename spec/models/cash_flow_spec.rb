require 'rails_helper'

describe CashFlow, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:kind) }
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:value) }
  end

  describe 'enums' do
    let(:category) do
      {
        membership: 'membership',
        donation: 'donation',
        other: 'other',
        mission: 'mission'
      }
    end

    let(:kind) do
      {
        input: 'input',
        output: 'output'
      }
    end

    it { is_expected.to define_enum_for(:kind).with_values(kind).backed_by_column_of_type(:string) }
    it { is_expected.to define_enum_for(:category).with_values(category).backed_by_column_of_type(:string) }
  end

  describe 'factories' do
    it { expect(build(:cash_flow)).to be_valid }
  end
end
