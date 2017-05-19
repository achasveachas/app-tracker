class Api::V1::ApplicationsController < ApplicationController
  before_action :authenticate_token!, only: [:create, :update, :destroy]

  def index

    @applications = User.find_by(id: params[:user_id])&.applications
    render 'applications/applications.json.jbuilder', applications: @applications

  end

  def show
    @application = Application.find_by(id: params[:id])
    if @application
      render 'applications/application.json.jbuilder', application: @application
    else
      render json: {
        errors: {
          message: "Page not found"
        }
      }, status: 404
    end
  end

  def create
    @user = User.find_by(id: params[:user_id])
    if @user.id == current_user.id
      @application = @user.applications.new(application_params)
      if @application.save
        render 'applications/application.json.jbuilder', application: @application
      else
        render json: {
          errors: @application.errors.full_messages
        }, status: 500
      end
    else
      render json: {
        errors: [
          {message: "You do not have permission to add applications to this user's dashboard."}
        ]
      }, status: 403
    end
  end

  def update
    @user = User.find_by(id: params[:user_id])
    if @user.id == current_user.id
      @application = @user.applications.find_by(id: params[:id])
      if @application.update_attributes(application_params)
        render 'applications/application.json.jbuilder', application: @application
      else
        render json: {
          errors: @application.errors.full_messages
        }, status: 500
      end
    else
      render json: {
        errors: [
          {message: "You do not have permission to edit this application."}
        ]
      }, status: 403
    end
  end

  def destroy
    application = Application.find_by(id: params[:id])
    if application
      application.destroy
      head :no_content
    else
      render json: {
        errors: {
          message: "Page not found"
        }
      }, status: 404
    end
  end

  private

  def application_params
    params.require(:application).permit(:company, :contact_name, :contact_title, :date, :action, :first_contact, :job_title, :job_url, :notes, :complete, :next_step, :status)
  end

end
