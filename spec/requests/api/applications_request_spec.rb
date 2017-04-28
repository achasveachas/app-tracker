require 'rails_helper'

RSpec.describe "API::V1::Applications", type: :request do

  befor(:each) do
    @user = create(:user)
    @application = @user.applications.create(company: "Google")
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

    post "/api/v1/users/#{@user.id}/applications", params: {comapny: "Yahoo"}, headers: @tokenless_headers
    responses << response
    response_bodies << JSON.parse(response.body)

    patch "/api/v1/users/#{@user.id}/applications/#{@application.id}", params: {comapny: "Yahoo"}, headers: @tokenless_headers
    responses << response
    response_bodies << JSON.parse(response.body)

    responses.each {|r| expect(r).to have_http_status(403)}
    response_bodies.each {|b| expect(b["errors"].to eq([{"message" => "Token is invalid"}]))}
  end

end
