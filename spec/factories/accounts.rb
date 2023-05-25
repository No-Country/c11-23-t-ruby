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
FactoryBot.define do
  factory :account do
    amount { 0 }
    user
  end
end
