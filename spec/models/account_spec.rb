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
require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:transactions) }
    it { should have_many(:loans) }
  end

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount) }
  end

  describe 'Create action' do
    context 'bafore save' do
      let(:user) { create(:user) }
      let(:account) { build(:account, user: user) }

      it "is persisted" do
        expect(account.save).to eq true
      end

      context 'after save' do
        before(:each) { account.save }

        it "has a generated code" do
          expect(account.code).to_not eq nil
        end

        it "has a amount equals to $0" do
          expect(account.current_amount).to eq 0
        end

        it "should have status management" do
          expect(account).to transition_from(:created).to(:activated).on_event(:activate)
          expect(account).to transition_from(:suspended).to(:activated).on_event(:activate)
          expect(account).to transition_from(:activated).to(:suspended).on_event(:suspend)
        end
      end
    end
  end
end
