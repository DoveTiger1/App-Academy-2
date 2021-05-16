class SessionsController < ApplicationController
    def new
        render :new
    end
    
    def create
        user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
        token = user.reset_session_token!
        session[:session_token] = token
        redirect_to cats_url
    end

    def destroy

    end

end