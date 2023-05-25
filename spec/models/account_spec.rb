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
  end

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount) }
  end
end
