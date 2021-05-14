class UsersController < ApplicationController
    def index
        render json: User.all
    end

    def create
        user = User.new(user_params)

        if user.save
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        user = User.find(params[:id])

        render json: user
    end

    def destroy
        user = User.find(params[:id])

        user.destroy

        render json: User.all
    end

    def update
        User.update(params[:id], user_params)

        render json: User.all
    end

    private

    def user_params
        params.require(:user).permit(:name, :email)
    end
end