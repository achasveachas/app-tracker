class ApplicationController < ActionController::API

  helper_method :authenticate_token!, :current_user

  private

  def authenticate_token!
    if request.env['HTTP_AUTHORIZATION']
      begin
        token = request.env['HTTP_AUTHORIZATION'].split(" ").last
        decoded = Auth.decode_token(token)
        @user_id = decoded[0]["user_id"]
      rescue JWT::DecodeError
        errors = [{message: "Token is invalid"}]
      end

      if !current_user || !decoded || errors
        render json: {
          errors: errors,
        }, status: 403
      end
    else
      render json: {
        errors: [
          {message: "You must include a JWT token"}
        ]
      }, status: 403
    end

  end

  def current_user
    @user ||= User.find_by(id: @user_id) if @user_id
  end
end
