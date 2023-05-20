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
  # Callback
  before_save :create_code

  # Before account saves, create code attribute
  def create_code
    self.code = "ACCOUNT CODE XXX"
  end
end
