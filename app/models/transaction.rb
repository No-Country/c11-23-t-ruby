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

  # Attributes validations
  validates :transaction_type, :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
  # Validates if account amount is enough to output transaction
  validates_with Transactions::GreaterThanAccountAmount, if: :is_output_transaction

  # Before transaction creation, generates self code
  before_create :generate_code
  # After transaction creation, updates account amount
  after_create :update_accout_amount

  enum transaction_type: {
    deposit: 1,
    withdraw: 2,
    transfer: 3
  }

  private

  def is_output_transaction
    transaction_type == "withdraw" or transaction_type == "transfer"
  end

  # Method to update account amount
  def update_accout_amount
    account.update!(
      amount: account.new_amount(transaction_type.to_sym, amount)
    )
  end

  # Microservice to code generation
  def generate_code
    Transactions::GenerateCode.new.call(self)
  end
end
