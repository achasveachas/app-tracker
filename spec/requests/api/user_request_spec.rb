require 'rails_helper'

RSpec.describe "API::V1::Users", type: :request do

  describe "/POST /users" do

    describe "on success" do

      it "creates a user from the params"

      it "returns the new user and a JWT token"
    end

    describe "on validation error" do

      it "required a valid email and password"
    end
  end
end
