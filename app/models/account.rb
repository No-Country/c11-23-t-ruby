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
  validates :amount, numericality: { greater_than: 0 }

  # Callback to a function
  before_create :generate_code

  enum transaction_type: {
    deposit: 1,
    withdraw: 2,
    transfer: 3
  }

  private
  # Before account saves, create code attribute
  def generate_code
    # This calls a microservice to generate code
    Accounts::GenerateCode.new.call(self)
  end
end
