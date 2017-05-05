class Api::V1::ApplicationsController < ApplicationController
  before_action :authenticate_token!, only: [:create, :update]

  def index
    @applications = User.find_by(id: params[:user_id])&.applications&.sort
    if @applications.size > 0
      render 'applications/applications.json.jbuilder', applications: @applications
    else
      render json: {
        errors: [
          {message: "Page not found"}
        ]
      }, status: 404
    end
  end

  def show
    @application = Application.find_by(id: params[:id])
    if @application
      render 'applications/application.json.jbuilder', application: @application
    else
      render json: {
        errors: [
          {message: "Page not found"}
        ]
      }, status: 404
    end
  end

  def create

  end

  def update

  end

end
