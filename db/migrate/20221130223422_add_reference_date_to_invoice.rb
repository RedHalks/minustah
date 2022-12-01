class AddReferenceDateToInvoice < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :reference_date, :date
    change_column_null :invoices, :reference_month, true
    change_column_null :invoices, :reference_year, true
  end
end
