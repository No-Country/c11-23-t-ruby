# == Schema Information
#
# Table name: loans
#
#  id         :bigint           not null, primary key
#  amount     :decimal(11, 2)   not null
#  code       :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#
class Loan < ApplicationRecord
  include AASM

  belongs_to :account

  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 1000 }

  scope :ordered, -> { order(id: :desc) }

  # Before create generates loan code
  before_create :generate_code
  after_create :send_email

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
    account.activated?
  end

  private

  # After approve loan, generates deposit to target account
  def generate_loan_deposit
    Loans::GenerateLoanDeposit.new.call(self)
  end

  # Call to microservice to code generation
  def generate_code
    Loans::GenerateCode.new.call(self)
  end

  # This is a background job to perform send email action
  def send_email
    return unless Rails.env.development?
    Loans::SendEmailJob.perform_in(2, id)
  end
end
