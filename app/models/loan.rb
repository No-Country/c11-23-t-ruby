# == Schema Information
#
# Table name: loans
#
#  id         :bigint           not null, primary key
#  amount     :decimal(11, 2)   not null
#  code       :string
#  status     :string
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Loan < ApplicationRecord
  include AASM

  belongs_to :user

  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }

  # Before create generates loan code
  before_create :generate_code

  # State machine to status management
  aasm column: :status do
    state :requested, initial: true
    state :approved, :refused

    event :approve, guard: :is_activated_account, after: :generate_loan_deposit do
      transitions from: [:requested, :refused], to: :approved
    end

    event :refuse do
      transitions from: [:requested, :approved], to: :refused
    end
  end

  def is_activated_account
    user.accounts.last.activated?
  end

  private

  # After approve loan, generates deposit to target account
  def generate_loan_deposit
    account = user.accounts.last
    account.transactions.create!(amount: amount, transaction_type: "deposit", options: { "from_loan" => code })
  end

  # Call to microservice to code generation
  def generate_code
    Loans::GenerateCode.new.call(self)
  end
end