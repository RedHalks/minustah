require 'rails_helper'
Rails.application.load_tasks

describe Rake::Task, type: :task do
  context 'when invoke task' do
    subject { described_class['import_cash_flow_initial_data'] }

    let(:invoke_action) { subject.invoke }
    let(:expected_results) {[
      { class: CashFlow, count: 41 },
      { class: Invoice, count: 81 }
    ]}

    before do
      (1..30).each do |i|
        create(:member, id: i)
      end

      invoke_action
    end

    it 'import all data' do
      expected_results.each do |expected|
        expect(expected[:class].count).to eq(expected[:count])
      end
    end
  end
end
