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
      let(:user) { create(:user) }
      let(:loan) { build(:loan,user: user, amount: 100) }
      before(:each) { loan.save }

      it "should have a generated code" do
        expect(loan.code).to_not eq nil
      end

      it "should have a initial state equals to requested" do
        expect(loan.status).to eq "requested"
      end

      it "should change status to approved" do
        loan.approve!
        expect(loan.status).to eq "approved"
      end

      it "should change status to refused" do
        loan.refuse!
        expect(loan.status).to eq "refused"
      end
    end
  end
end
