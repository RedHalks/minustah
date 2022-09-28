class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :state, null: false
      t.string :kind, null: false
      t.string :nickname

      t.belongs_to :person

      t.timestamps
    end
  end
end
