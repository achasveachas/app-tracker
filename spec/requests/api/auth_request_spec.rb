require 'rails_helper'

RSpec.describe "API::V1::Users", type: :request do

  describe "/POST /auth" do

    describe "on success" do

      before(:each) do
        User.create(username: "testuser", password: "testtest")
      end

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
        expect(body['user']['password_digest']).to eq(nil)

      end
    end

    describe "on error" do

      before(:each) do
        User.create(username: "testuser", password: "testtest")
      end

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

        expect(response.status).to eq(500)
        expect(body["errors"]).to eq({
          "username"=>["Unable to find user with that username"]
        })

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

        expect(response.status).to eq(500)
        expect(body["errors"]).to eq({
          "password"=>["Password does not match"]
        })
      end
    end
  end
end
