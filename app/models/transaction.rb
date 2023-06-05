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
#  options          :hstore
#
class Transaction < ApplicationRecord
  belongs_to :account

  # Validations
  validates :transaction_type, :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
  # Validates if account amount is enough to output transaction
  validates_with Transactions::ActivatedAccount
  validate :target_account_exist, if: :is_transfer_transaction
  # validates_with Transactions::ActivatedTargetAccount, if: :is_transfer_transaction
  validates_with Transactions::GreaterThanAccountAmount, if: :is_output_transaction

  scope :ordered, -> { order(id: :desc) }
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

  # Method to validate if target_account exists or is not activated.
  def target_account_exist
    target_account = Account.find_by(code: options["target_account"])
    if target_account.nil?
      errors.add(:base, "Target account does not exist.")
    elsif target_account.status != "activated"
      errors.add(:base, "Target account is not activated.")
    end
  end

  # Method to validate if is a output transaction
  def is_output_transaction
    transaction_type == "withdraw" or transaction_type == "transfer"
  end

  # Method to validate if is a transfer transaction
  def is_transfer_transaction
    transaction_type == "transfer"
  end

  # Method to update account amount
  def update_accout_amount
    account.update!(
      amount: account.new_amount(transaction_type.to_sym, amount)
    )
    # if is a transfer transaction makes the transfer
    generate_transfer if is_transfer_transaction
  end

  # Call to microservice to code generation
  def generate_code
    Transactions::GenerateCode.new.call(self)
  end

  # Call to microservice to generate a transfer transaction
  def generate_transfer
    Transactions::GenerateTransfer.new.call(self)
  end
end
