class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.integer :reference_month, null: false
      t.integer :reference_year, null: false
      t.float :value, null: false
      t.string :category, null: false

      t.belongs_to :cash_flow
      t.belongs_to :member

      t.index [:member_id, :reference_month, :reference_year], unique: true, name: 'index_invoices_once_per_month'

      t.timestamps
    end
  end
end
