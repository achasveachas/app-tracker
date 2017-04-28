require 'rails_helper'

RSpec.describe "API::V1::Applications", type: :request do

  befor(:each) do
    @user = create(:user)
    @token = Auth.create_token(@user.id)
  end

  it "requires all routes to have a token" do
  end

end
