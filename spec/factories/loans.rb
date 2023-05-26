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
FactoryBot.define do
  factory :loan do
    amount { 150 }
    account
  end
end
