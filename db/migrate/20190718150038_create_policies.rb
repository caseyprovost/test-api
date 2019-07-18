class CreatePolicies < ActiveRecord::Migration[5.2]
  def change
    create_table :policies do |t|
      t.references :agent, foreign_key: true, index: true, null: false
      t.references :carrier, foreign_key: true, index: true, null: false
      t.references :industry, foreign_key: true, index: true, null: false
      t.decimal :premium_amount, null: false, precision: 18, scale: 6
      t.string :policy_holder, null: false

      t.timestamps
    end
  end
end
