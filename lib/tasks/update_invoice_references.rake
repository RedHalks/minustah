task update_invoice_references: :environment do
  invoices = Invoice.all

  invoice_reference_dates = invoices.map do |invoice|
    { id: invoice.id, reference_date: Date.new(invoice.reference_year, invoice.reference_month, 1) }
  end.index_by { |invoice| invoice[:id] }

  Invoice.update(invoice_reference_dates.keys, invoice_reference_dates.values)
end
