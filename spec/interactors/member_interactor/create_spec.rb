# frozen_string_literal: true

require 'rails_helper'

describe MemberInteractor::Create, type: :interactor do
  subject(:interactor) { described_class.call(params:) }

  describe '#call' do
    let(:member_attrs) { attributes_for(:member) }
    let(:person_attrs) { attributes_for(:person) }
    let(:params) { member_attrs.merge({ person: person_attrs }) }

    it 'creates a member' do
      expect { interactor }.to change(Member, :count).by(1).and change(Person, :count).by(1)

      member = interactor.member
      expect(member).to have_attributes(member_attrs)
      expect(member.person).to have_attributes(person_attrs)
    end
  end
end
