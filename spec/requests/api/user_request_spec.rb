require 'rails_helper'

RSpec.describe "API::V1::Users", type: :request do

  describe "POST /users" do

    describe "on success" do

      before(:each) do
        params = {
          user: {
            username: "testuser",
            password: "testtest"
          }
        }

        post "/api/v1/users",
          params: params.to_json,
          headers: { 'Content-Type': 'application/json'}

        @response = response

      end

      it "creates a user from the params" do
        expect(User.all.count).to eq(1)
      end

      it "returns the new user and a JWT token" do
        body = JSON.parse(@response.body)

        expect(@response.status).to eq(200)
        expect(body['token']).not_to eq(nil)
        expect(body['user']['id']).not_to eq(nil)
        expect(body['user']['username']).to eq("testuser")
        expect(body['user']['password_digest']).to eq(nil)

      end
    end

    describe "on validation error" do

      it "required a valid email and password" do
        params = {
          user: {
            username: "",
            password: ""
          }
        }

        post "/api/v1/users",
          params: params.to_json,
          headers: { 'Content-Type': 'application/json'}

        body = JSON.parse(response.body)

        expect(response.status).to eq(500)
        expect(body["errors"]).to eq({
          "password"=>["can't be blank", 'is too short (minimum is 8 characters)'],
          "username"=>["can't be blank"]
        })
      end
    end
  end

  describe "GET /users/:id" do

    describe "on success" do
      before(:each) do
        @user = create(:user)
      end

      it "returns a list of all users" do
        get "/api/v1/users/#{@user.id}"

        body = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(body['user']['id']).to eq(@user.id)
        expect(body['user']['username']).to eq(@user.username)
        expect(body['user']['password_digest']).to eq(nil)

      end
    end

    describe "on failure" do
      it "returns a status of 404 with an error message" do

        get "/api/v1/users/5"

        body = JSON.parse(response.body)

        expect(response.status).to eq(404)
        expect(body["errors"]).to eq([{"message"=> "Page not found"}])

      end
    end
  end
end
