# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  code       :string           not null
#  amount     :decimal(11, 2)   not null
#  status     :string           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Account < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true, numericality: true
  # Callback to a function
  before_create :generate_code

  private
  # Before account saves, create code attribute
  def generate_code
    # This calls a microservice to generate code
    Accounts::GenerateCode.new.call(self)
  end
end
