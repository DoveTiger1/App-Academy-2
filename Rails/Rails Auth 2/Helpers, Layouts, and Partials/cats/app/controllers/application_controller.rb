class ApplicationController < ActionController::Base
    helper_method :current_user

    def require_no_user!
        redirect_to cats_url if current_user
    end

    def current_user
        User.find_by(session_token: session[:session_token])
    end

    def login_user!(user)
        token = user.reset_session_token!
        session[:session_token] = token
    end
end
