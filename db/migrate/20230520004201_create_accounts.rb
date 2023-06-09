class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :code
      t.decimal :amount, precision: 11, scale: 2, null: false
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
