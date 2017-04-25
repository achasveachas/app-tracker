require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires a username and a password upon creation' do
      user = build(:user, username: nil, password: nil)

      expect(user.valid?).to equal(false)
      expect(user.errors.full_messages).to eq([
        "Password can't be blank",
        "Username can't be blank"
        ])
    end

    it 'requires that the username be unique' do
      create(:user)
      user = build(:user)

      expect(user.valid?).to equal(false)
      expect(user.errors.full_messages).to eq([
        "Username has already been taken"
        ])
    end

  end

  describe 'on save' do
    it 'hashes a password'
  end

  describe 'relationships' do
    it 'has many applications'
  end

end
