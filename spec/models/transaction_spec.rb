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
require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'associations' do
    it { should belong_to(:account) }
  end

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:transaction_type) }
    it { should validate_numericality_of(:amount) }
    it { should define_enum_for(:transaction_type).with_values(deposit: 1, withdraw: 2, transfer: 3) }
  end

  describe "valid data" do
    context "on deposit transaction" do
      let!(:account) { create(:account) }
      let!(:transaction) { create(:transaction, account: account, transaction_type: :deposit, amount: 100) }

      it "account amount should be 100" do
        account.reload
        expect(account.current_amount).to eq 100
      end

      it "should has a generated code" do
        expect(transaction.code).to_not eq nil
      end
    end

    context "on withdraw transaction" do
      let!(:account) { create(:account, amount: 100) }
      let!(:transaction) { create(:transaction, account: account, transaction_type: :withdraw, amount: 75) }

      it "account amount should be 100" do
        account.reload
        expect(account.current_amount).to eq 25
      end

      it "should has a generated code" do
        expect(transaction.code).to_not eq nil
      end
    end

    context "on transfer transaction" do
      let!(:account_1) { create(:account, amount: 100) }
      let!(:account_2) { create(:account) }
      let!(:transaction) { create(
        :transaction,
        account: account_1,
        transaction_type: :transfer,
        amount: 50,
        options: { "target_account" => account_2.id }
        ) }

      it "transfer transaction successfuly done" do
        account_1.reload
        account_2.reload
        expect(account_1.current_amount).to eq 50
        expect(account_2.current_amount).to eq 50
      end

      it "target_account should have a deposit transaction from the other account" do
        expect(account_1.transactions.last.options["target_account"].to_i).to eq account_2.id
        expect(account_2.transactions.last.options["from_account"].to_i).to eq account_1.id
      end
    end
  end
end
