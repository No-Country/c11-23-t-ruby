class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :transaction_type, null: false
      t.decimal :amount, precision: 11, scale: 2, null: false
      t.string :code
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
