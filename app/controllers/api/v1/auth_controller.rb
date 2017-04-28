class Api::V1::AuthController < ApplicationController

  def login
    @user = User.find_by(username: params[:user][:username])
    if !@user
      render json: {
        errors: {
          username: ["Unable to find user with that username"]
        }
      }, status: 500
    elsif @user&.authenticate(params[:user][:password])
      render 'users/user_with_token.json.jbuilder', user: @user
    else
      render json: {
        errors: {
          password: ["Password does not match"]
        }
      }, status: 500
    end
  end

end
