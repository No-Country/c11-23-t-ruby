class RemoveUserReferencesFromLoan < ActiveRecord::Migration[7.0]
  def change
    remove_reference :loans, :user, null: false, foreign_key: true
  end
end
