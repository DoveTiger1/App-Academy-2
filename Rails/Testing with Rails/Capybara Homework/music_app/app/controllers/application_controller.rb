class ApplicationController < ActionController::Base

    helper_method :current_user
    helper_method :logged_in?

    private

    def current_user
        return nil unless session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def login_user!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logged_in?
        !current_user.nil?
    end

    def require_no_user!
        redirect_to user_url(current_user) if current_user
    end

    def require_user!
        redirect_to new_session_url if current_user.nil?
    end

end
