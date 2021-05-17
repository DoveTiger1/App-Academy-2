class CatsController < ApplicationController
    before_action :require_cat_owner!, only: [:edit, :update]

    def index
        @cats = Cat.all
        render :index
    end

    def show
        @cat = Cat.find_by(id: params[:id])

        if @cat
            render :show
        else
            redirect_to cats_url
        end
    end

    def new
        @cat = Cat.new
        render :new
    end

    def create
        @cat = Cat.new(cat_params)
        @cat.user_id = current_user.id

        if @cat.save
            redirect_to cat_url(@cat)
        else
            render :new
        end
    end

    def edit
        @cat = Cat.find_by(id: params[:id])
        render :edit
    end

    def update
        @cat = Cat.find_by(id: params[:id])

        if @cat.update_attributes(cat_params)
            redirect_to cat_url(@cat)
        else
            render :edit
        end
    end

    private

    def require_cat_owner!
        user = current_user
        if user.nil? || !user.cats.find(params[:id])
            redirect_to cat_url(params[:id])
        else
            return
        end
    end

    def cat_params
        params.require(:cat).permit(:name, :sex, :color, :birth_date, :description)
    end
end