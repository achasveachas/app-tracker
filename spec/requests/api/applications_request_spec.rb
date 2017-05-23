require 'rails_helper'

RSpec.describe "API::V1::Applications", type: :request do

  describe "authentication" do

    before(:each) do
      @user = create(:user)
      @application = @user.applications.create(company: Faker::Company.name)
      @token = Auth.create_token(@user.id)
      @token_headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer: #{@token}"
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
      @application = @user.applications.first
      @token = Auth.create_token(@user.id)
      @token_headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer: #{@token}"
      }
    end

    describe "GET /api/v1/users/:id/applications" do

      it "returns an array of applications belonging to a given user" do

        get "/api/v1/users/#{@user.id}/applications"

        body = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(body['applications']).to be_an(Array)
        expect(body['applications'].size).to eq(3)
      end

      it "doesn't return applications belonging to other users" do
        user2 = User.create(username: "user2", password: "password2")
        application2 = user2.applications.create(company: "Wrong Company")

        get "/api/v1/users/#{@user.id}/applications"
        body = JSON.parse(response.body)
        expect(body['applications'].last['user_id']).not_to eq(user2.id)
      end
    end

    describe "GET /api/v1.users/:user_id/applications/:id" do

      describe "on success" do

        it "returns on application based on its id" do

          get "/api/v1/users/#{@user.id}/applications/#{@application.id}"

          body = JSON.parse(response.body)

          expect(response.status).to eq(200)
          expect(body['application']).not_to eq(nil)
          expect(body['application']['id']).to eq(@application.id)
        end

      end

      describe "on failure" do
        it "returns a status of 404 with an error message" do

          get "/api/v1/users/#{@user.id}/applications/fakeid"

          body = JSON.parse(response.body)

          expect(response.status).to eq(404)
          expect(body["errors"]).to eq({"message"=> "Page not found"})

        end
      end
    end

    describe "POST /api/v1/users/:id/applications" do
      params = {
        application: {
          company: 'Google',
          contact_name: 'Larry Page',
          contact_title: 'CEO',
          date: '05/15/17',
          action: "Meeting",
          first_contact: false,
          job_title: 'Lead Developer',
          job_url: 'google.com',
          notes: 'Test data',
          complete: false,
          next_step: "Get Job",
          status: nil
        }
      }

      before(:each) do
        post "/api/v1/users/#{@user.id}/applications",
          params: params.to_json,
          headers: @token_headers

        @body = JSON.parse(response.body)
      end

      it "creates a new instance of an Application" do

        application = Application.last
        expect(application.company).to eq(params[:application][:company])
        expect(application.contact_name).to eq(params[:application][:contact_name])
        expect(application.contact_title).to eq(params[:application][:contact_title])
        expect(application.date).to eq(params[:application][:date])
        expect(application.action).to eq(params[:application][:action])
        expect(application.first_contact).to eq(params[:application][:first_contact])
        expect(application.job_title).to eq(params[:application][:job_title])
        expect(application.job_url).to eq(params[:application][:job_url])
        expect(application.notes).to eq(params[:application][:notes])
        expect(application.complete).to eq(params[:application][:complete])
        expect(application.next_step).to eq(params[:application][:next_step])
        expect(application.status).to eq(params[:application][:status])
      end

      it "returns the new Application" do
        application = Application.last

        expect(@body['application']['id']).to eq(application.id)
        expect(@body['application']['company']).to eq(application.company)
      end
    end

    describe "PATCH /api/v1/users/:id/applications" do
      params = {
        application: {
          company: 'Google',
          contact_name: 'Larry Page',
          contact_title: 'CEO',
          date: '05/15/17',
          action: "Meeting",
          first_contact: false,
          job_title: 'Lead Developer',
          job_url: 'google.com',
          notes: 'Test data',
          complete: false,
          next_step: "Get Job",
          status: nil
        }
      }

      before(:each) do
        patch "/api/v1/users/#{@user.id}/applications/#{@user.applications.last.id}",
          params: params.to_json,
          headers: @token_headers

        @body = JSON.parse(response.body)
      end

      it "updates the application" do
        application = Application.last
        expect(application.company).to eq(params[:application][:company])
        expect(application.contact_name).to eq(params[:application][:contact_name])
        expect(application.contact_title).to eq(params[:application][:contact_title])
        expect(application.date).to eq(params[:application][:date])
        expect(application.action).to eq(params[:application][:action])
        expect(application.first_contact).to eq(params[:application][:first_contact])
        expect(application.job_title).to eq(params[:application][:job_title])
        expect(application.job_url).to eq(params[:application][:job_url])
        expect(application.notes).to eq(params[:application][:notes])
        expect(application.complete).to eq(params[:application][:complete])
        expect(application.next_step).to eq(params[:application][:next_step])
        expect(application.status).to eq(params[:application][:status])
      end

      it "returns the updated Application" do
        application = Application.last

        expect(@body['application']['id']).to eq(application.id)
        expect(@body['application']['company']).to eq(application.company)
      end
    end

    describe "DELETE /api/v1.users/:user_id/applications/:id" do

      describe "on success" do

        it "deletes the application and returns a status of 204" do
          delete "/api/v1/users/#{@user.id}/applications/#{@application.id}",
            headers: @token_headers


          expect(Application.find_by(id: @application.id)).to eq(nil)
          expect(response.status).to eq(204)

        end

      end

      describe "on failure" do
        it "returns a status of 404 with an error message" do

          delete "/api/v1/users/#{@user.id}/applications/fakeid",
            headers: @token_headers


          body = JSON.parse(response.body)
          expect(response.status).to eq(404)
          expect(body["errors"]).to eq({"message"=> "Page not found"})

        end
      end
    end
  end

end
