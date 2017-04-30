require 'rails_helper'

RSpec.describe "API::V1::Applications", type: :request do

  describe "authentication" do

    before(:each) do
      @user = create(:user)
      @application = @user.applications.create(company: Faker::Company.name)
      @token = Auth.create_token(@user.id)
      @token_headers = {
        'Content-Type': 'application/json'
      }
      @tokenless_headers = {
        'Content-Type': 'application/json',
      }
    end

    it "requires a token to make and edit an application" do
      responses = []
      response_bodies = []

      post "/api/v1/users/#{@user.id}/applications", headers: @tokenless_headers
      responses << response
      response_bodies << JSON.parse(response.body)


      patch "/api/v1/users/#{@user.id}/applications/#{@application.id}", headers: @tokenless_headers
      responses << response
      response_bodies << JSON.parse(response.body)

      responses.each {|r| expect(r).to have_http_status(403)}
      response_bodies.each {|body| expect(body["errors"]).to eq([{"message" => "You must include a JWT token"}])}
    end

  end

  describe "routes" do

    before(:each) do
      @user = create(:user)
      3.times do
        @user.applications.create(company: Faker::Company.name)
      end
    end

    describe "GET /api/v1/users/:id/applications" do

      it "returns an array of applications belonging to a given user" do

        get "/api/v1/users/#{@user.id}/applications"

        body = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(body['applications']).to be_an(Array)
        expect(body['applications'].size).to eq(3)
      end

      it "doesn't return applications belonging to other users"
    end

  end

end
