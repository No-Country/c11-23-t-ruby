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
  belongs_to :user

  has_many :transactions, dependent: :destroy

  # Attributes validations
  validates :amount, presence: true, numericality: true

  # Bafore accont creation generate self code
  before_create :generate_code

  # Current accunt amount
  def current_amount
    amount
  end

  # Method to compute new account amount after a transaction
  def new_amount(transaction_type, amount)
    new_amount = 0
    case transaction_type
    when "deposit"
      new_amount = current_amount + amount
    when "withdraw"
      new_amount = current_amount - amount
    when "transfer"
      new_amount = current_amount - amount
    when "expense"
      new_amount = current_amount - amount
    end
    new_amount
  end

  private
  # Before account saves, create code attribute
  def generate_code
    # This calls a microservice to generate code
    Accounts::GenerateCode.new.call(self)
  end
end
