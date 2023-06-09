# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  code       :string
#  amount     :decimal(11, 2)   not null
#  status     :string
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Account < ApplicationRecord
  include AASM

  belongs_to :user

  has_many :transactions, dependent: :destroy
  has_many :loans, dependent: :destroy

  # Attributes validations
  validates :user_id, presence: true
  validates :amount, presence: true, numericality: true

  scope :ordered, -> { order(id: :asc) }

  # Bafore accont creation generate self code
  before_create :generate_code
  after_create :send_email

  # Current accunt amount
  def current_amount
    amount
  end

  # Method to compute new account amount after a transaction
  def new_amount(transaction_type, amount)
    new_amount = {
      deposit: current_amount + amount,
      withdraw: current_amount - amount,
      transfer: current_amount - amount
    }
    new_amount[transaction_type]
  end

  aasm column: :status do
    state :created, initial: true
    state :activated, :suspended

    after_all_transitions :send_account_status_email

    event :activate do
      transitions from: [:created, :suspended], to: :activated
    end

    event :suspend do
      transitions from: :activated, to: :suspended
    end
  end

  # Method to validate if an account has at least a requested loan
  def has_one_requested_loan?
    loans.where(status: "requested").count > 0
  end

  private
  # Before account saves, create code attribute
  def generate_code
    # This calls a microservice to generate code
    Accounts::GenerateCode.new.call(self)
  end

  # This is a background job to perform send email action
  def send_email
    # return unless Rails.env.development?
    Accounts::SendEmailJob.perform_async(id)
  end

  # This is a background job to perform send email action on account status change
  def send_account_status_email
    # return unless Rails.env.development?
    Accounts::SendAccountStatusEmailJob.perform_in(2, id)
  end
end
