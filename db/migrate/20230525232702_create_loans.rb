class CreateLoans < ActiveRecord::Migration[7.0]
  def change
    create_table :loans do |t|
      t.decimal :amount, precision: 11, scale: 2, null: false
      t.string :code
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
