require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    FactoryBot.build(:user,
    email: 'testing@gmail.com',
    password: 'testing')
  end
  
  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:session_token)}
  it { should validate_presence_of(:password_digest)}
  it { should validate_length_of(:password).is_at_least(6) }

  

  describe "#is_password?" do
    it 'checks if the user password is equal to the param' do
        expect(user.is_password?('testing')).to be true
        expect(user.is_password?('test')).to be false
    end
  end

  describe "#reset_session_token" do
    it 'resets the users session token' do
      user.valid?
      initial_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).not_to eq(initial_token)
    end
  end

  describe '.find_by_credentials' do
    before { user.save! }

    it 'searches a user by the credentials and returns it' do
      expect(User.find_by_credentials('testing@gmail.com', 'testing')).to eq(user)
      expect(User.find_by_credentials('asd@gmail.com', 'asdsad')).to be nil
    end
  end
  
end
