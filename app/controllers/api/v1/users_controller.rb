class Api::V1::UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      render 'users/user_with_token.json.jbuilder', user: @user
    else
      render json: {
        errors: @user.errors.full_messages
      }, status: 500
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user
      render 'users/user_without_token.json.jbuilder', user: @user
    else
      render json: {
        errors: [
          {message: "Page not found"}
        ]
      }, status: 404
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :password)
  end
end
