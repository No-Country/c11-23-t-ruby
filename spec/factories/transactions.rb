# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  transaction_type :integer          not null
#  amount           :decimal(11, 2)   not null
#  code             :string
#  account_id       :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  options          :hstore
#
FactoryBot.define do
  factory :transaction do
    transaction_type {'deposit'}
    amount { 100 }
    account

    trait :deposit do
      transaction_type { 1 }
    end
    trait :withdraw do
      transaction_type { 2 }
    end
    trait :transfer do
      transaction_type { 3 }
    end
  end
end
