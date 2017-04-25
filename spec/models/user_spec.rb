require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires a username and a password upon creation'
    it 'requires that the username be unique'
  end

  describe 'relationships' do
    it 'has many applications'
  end
  
end
