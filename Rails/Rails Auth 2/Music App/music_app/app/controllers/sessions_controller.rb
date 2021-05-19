class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(user_params)
        
        if @user
            login_user!(@user)
            redirect_to user_url(@user)
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

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end