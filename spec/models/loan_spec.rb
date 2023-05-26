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
require 'rails_helper'

RSpec.describe Loan, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount) }
  end

  describe "valid data" do
    context "on create action" do
      let!(:user) { create(:user) }
      let!(:account) { create(:account, user: user) }
      let(:amount) { 100 }
      let(:loan) { build(:loan,user: user, amount: amount) }
      before(:each) { account.activate! }
      before(:each) { loan.save }

      it "should have a generated code" do
        expect(loan.code).to_not eq nil
      end

      it "should have status management" do
        expect(loan).to transition_from(:requested).to(:approved).on_event(:approve)
        expect(loan).to transition_from(:refused).to(:approved).on_event(:approve)
        expect(loan).to transition_from(:requested).to(:refused).on_event(:refuse)
        expect(loan).to transition_from(:approved).to(:refused).on_event(:refuse)
      end

      it "should generate deposit transaction to account if has a activated status" do
        old_amount = account.current_amount
        loan.approve!
        account.reload
        current_amount = account.current_amount
        expect(current_amount).to eq(old_amount + amount)
      end
    end
  end
end
