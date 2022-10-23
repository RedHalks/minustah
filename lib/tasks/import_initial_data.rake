require 'csv'

desc 'Import initial data for cash flow and invoice'
task import_cash_flow_initial_data: :environment do
  files_path = Rails.root.join('lib/assets/csv/initial_data.csv')

  cash_flow_data = {}
  ::CSV.foreach(files_path, headers: true) do |row|
    ref = "#{row['member_id']} - #{row['moved_at']}"
    cash_flow_data[ref] ||= {}

    cash_flow_data[ref][:member_id] = row['member_id']
    cash_flow_data[ref][:moved_at] = row['moved_at']
    cash_flow_data[ref][:value] ||= 0
    cash_flow_data[ref][:value] += row['value'].to_i
    cash_flow_data[ref][:invoice] ||= []
    cash_flow_data[ref][:invoice] << {
      ref_month: row['ref_month'],
      ref_year: row['ref_year'],
      value: row['value']
    }
  end

  cash_flow_data.each_value do |data|
    cash_flow = CashFlow.new(
      member_id: data[:member_id],
      moved_at: data[:moved_at],
      value: data[:value],
      kind: :input,
      category: :membership
    )

    cash_flow.save!

    data[:invoice].each do |invoice_data|
      Invoice.new(
        category: :membership,
        reference_month: invoice_data[:ref_month],
        reference_year: invoice_data[:ref_year],
        value: invoice_data[:value],
        member_id: cash_flow.member_id,
        cash_flow_id: cash_flow.member_id
      ).save!
    end
  end
end
