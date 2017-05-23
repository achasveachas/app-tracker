class Api::V1::AuthController < ApplicationController
  before_action :authenticate_token!, only: [:refresh]

  def login
    @user = User.find_by(username: params[:user][:username])
    if !@user
      render json: {
        errors: ["Unable to find user with that username"]
      }, status: 403
    elsif @user&.authenticate(params[:user][:password])
      render 'users/user_with_token.json.jbuilder', user: @user
    else
      render json: {
        errors: ["Password does not match"]
      }, status: 403
    end
  end

  def refresh
    render 'users/user_with_token.json.jbuilder', user: current_user
  end

  def ping
    render json: {
      status: "OK"
    }
  end

end
