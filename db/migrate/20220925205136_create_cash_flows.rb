class CreateCashFlows < ActiveRecord::Migration[7.0]
  def change
    create_table :cash_flows do |t|
      t.string :kind, null: false
      t.float :value, null: false
      t.string :category, null: false

      t.belongs_to :member

      t.timestamps
    end
  end
end
