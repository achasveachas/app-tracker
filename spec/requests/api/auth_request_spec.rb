require 'rails_helper'

RSpec.describe "API::V1::Users", type: :request do

  before(:each) do
    @user = User.create(username: "testuser", password: "testtest", name: "testname")
  end

  describe "/POST /auth" do

    describe "on success" do

      before(:each) do
        params = {
          user: {
            username: "testuser",
            password: "testtest"
          }
        }

        post "/api/v1/auth",
          params: params.to_json,
          headers: { 'Content-Type': 'application/json'}

        @response = response

      end

      it "returns existing user (from params) and JWT token" do
        body = JSON.parse(response.body)

        expect(@response.status).to eq(200)
        expect(body['token']).not_to eq(nil)
        expect(body['user']['id']).not_to eq(nil)
        expect(body['user']['username']).to eq("testuser")
        expect(body['user']['name']).to eq("Testname")
        expect(body['user']['password_digest']).to eq(nil)

      end
    end

    describe "on error" do

      it "unable to find username" do

        params = {
          user: {
            username: "yechielk",
            password: "testtest"
          }
        }

        post "/api/v1/auth",
          params: params.to_json,
          headers: { 'Content-Type': 'application/json'}

        body = JSON.parse(response.body)

        expect(response.status).to eq(403)
        expect(body["errors"]).to eq(["Unable to find user with that username"])

      end

      it "password does not match" do

        params = {
          user: {
            username: "testuser",
            password: "wrong_password"
          }
        }

        post "/api/v1/auth",
          params: params.to_json,
          headers: { 'Content-Type': 'application/json'}

        body = JSON.parse(response.body)

        expect(response.status).to eq(403)
        expect(body["errors"]).to eq(["Password does not match"])
      end
    end
  end

  describe 'POST /auth/refresh' do
    describe "on success" do

      it "returns existing user (from the headers) and JWT token" do
        token = Auth.create_token(@user.id)

        post "/api/v1/auth/refresh",
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer: #{token}"
          }

        body = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(body['token']).not_to eq(nil)
        expect(body['user']['id']).not_to eq(nil)
        expect(body['user']['username']).to eq("testuser")
        expect(body['user']['name']).to eq("Testname")
        expect(body['user']['password_digest']).to eq(nil)

      end
    end

    describe "on error" do

      it "unable to find username" do

        token = 'asdfghjkl456'

        post "/api/v1/auth/refresh",
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer: #{token}"
          }

        body = JSON.parse(response.body)

        expect(response.status).to eq(403)
        expect(body["errors"]).to eq([{"message" => "Token is invalid"}])

      end
    end
  end
end
