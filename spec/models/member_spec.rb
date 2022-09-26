require 'rails_helper'

describe Member, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:kind) }
    it { is_expected.to validate_presence_of(:state) }
  end

  describe 'enums' do
    let(:state) do
      {
        active: 'active',
        inactive: 'inactive',
        reserve: 'reserve'
      }
    end

    let(:kind) do
      {
        rookie: 'rookie',
        official: 'official'
      }
    end

    it { is_expected.to define_enum_for(:state).with_values(state).backed_by_column_of_type(:string) }
    it { is_expected.to define_enum_for(:kind).with_values(kind).backed_by_column_of_type(:string) }
  end

  describe 'factories' do
    it { expect(build(:member)).to be_valid }
  end
end
