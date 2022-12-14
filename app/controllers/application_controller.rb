class ApplicationController < ActionController::API
  def current_user
    auth_headers = request.headers["Authorization"]
    if auth_headers.present? && auth_headers[/(?<=\A(Bearer ))\S+\z/]
      token = auth_headers[/(?<=\A(Bearer ))\S+\z/]
      begin
        decoded_token = JWT.decode(
          token,
          Rails.application.credentials.fetch(:secret_key_base),
          true,
          { algorithm: "HS256" }
        )
        User.find_by(id: decoded_token[0]["user_id"])
      rescue JWT::ExpiredSignature
        nil
      end
    end
  end

  def authenticate_user
    unless current_user
      render json: {msg: "You aren't logged in"}, status: :unauthorized
    end
  end

  def authenticate_admin
    unless current_user&.admin?
      render json: {msg: "You aren't an admin"}, status: :unauthorized
    end
  end

  def check_user(msg="You aren't logged in")
    if current_user
      yield
    else
      render json: {msg: msg}, status: :unauthorized
    end
  end
end
