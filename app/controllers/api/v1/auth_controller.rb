class Api::V1::AuthController < ApplicationController

  def login
    render json: {:hello=>"Hello"}
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
