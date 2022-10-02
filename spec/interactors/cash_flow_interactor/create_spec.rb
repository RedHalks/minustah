# frozen_string_literal: true

require 'rails_helper'

describe CashFlowInteractor::Create, type: :interactor do
  subject(:interactor) { described_class.call(params:) }

  describe '#call' do
    let(:cash_flow_attrs) do
      member = create(:member)
      attributes_for(:cash_flow).merge({ member_id: member.id })
    end
    let(:params) { cash_flow_attrs }

    it 'creates a member' do
      expect { interactor }.to change(CashFlow, :count).by(1)

      expect(interactor.cash_flow).to have_attributes(cash_flow_attrs)
    end
  end
end
