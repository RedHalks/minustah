# frozen_string_literal: true

require 'rails_helper'

describe MemberInteractor::Update, type: :interactor do
  subject(:interactor) { described_class.call(member:, params:) }

  describe '#call' do
    let(:member) { create(:member) }
    let(:member_attrs) { attributes_for(:member) }
    let(:person_attrs) { attributes_for(:person) }
    let(:params) { member_attrs.merge({ person_attributes: person_attrs }) }

    it 'update the member' do
      expect { interactor }.not_to change(member, :person_id)

      expect(member.reload).to have_attributes(member_attrs)
      expect(member.person).to have_attributes(person_attrs)
    end
  end
end
