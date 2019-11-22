class ApplicationController < ActionController::Base

  private

  def current_admin
    token = request.headers["Authorization"].to_s
    email = Base64.decode64(token)
    Admin.find_by(email: email)
  end
end
