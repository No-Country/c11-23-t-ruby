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
FactoryBot.define do
  factory :loan do
    amount { 150 }
    user
  end
end
