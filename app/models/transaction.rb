# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  transaction_type :integer          not null
#  amount           :decimal(11, 2)   not null
#  code             :string
#  account_id       :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Transaction < ApplicationRecord
  belongs_to :account

  validates :transaction_type, :amount, presence: true

  before_create :generate_code

  private

  def generate_code
    Transactions::GenerateCode.new.call(self)
  end
end
