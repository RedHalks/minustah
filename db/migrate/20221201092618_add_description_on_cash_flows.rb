class AddDescriptionOnCashFlows < ActiveRecord::Migration[7.0]
  def change
    add_column :cash_flows, :description, :string
  end
end
