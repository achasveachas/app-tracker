require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it 'belongs to a user' do
      user = create(:user)
      app = user.applications.create(company: "Google", action: "email", complete: false)

      expect(app.user.id).to eq(user.id)
    end
  end
end
