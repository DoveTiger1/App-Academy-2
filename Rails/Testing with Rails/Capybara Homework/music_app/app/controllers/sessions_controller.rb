class SessionsController < ApplicationController
    before_action :require_no_user!, only: [:new, :create]
    before_action :require_user!, only: [:destroy]

    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
        
        if @user
            login_user!(@user)
            redirect_to bands_url
        else
            render :new
        end
    end

    def destroy
        user = current_user
        user.reset_session_token!
        session[:session_token] = nil
        redirect_to new_session_url
    end
end