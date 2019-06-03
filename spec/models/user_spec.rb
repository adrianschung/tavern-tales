# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'creates an account' do
    it 'creates a valid user' do
      user = FactoryBot.create(:user)
      expect(user.username).to eq('user')
      expect(user.email).to eq('email1@email.com')
      expect(user.password).to eq('password')
      expect(User.count).to eq(1)
    end

    it 'does not create if username is taken' do
      FactoryBot.create(:user)
      user2 = FactoryBot.build(:user)
      expect(user2).to_not be_valid
      expect(User.count).to eq(1)
    end

    it 'does not create if username is invalid' do
      user = FactoryBot.build(:user, username: '@@@@')
      expect(user).to_not be_valid
      expect(User.count).to eq(0)
    end
  end
end
