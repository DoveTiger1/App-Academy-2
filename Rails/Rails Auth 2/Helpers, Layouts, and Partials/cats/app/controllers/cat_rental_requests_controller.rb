class CatRentalRequestsController < ApplicationController
    before_action :require_owner!, only: [:approve, :deny]
    before_action :must_be_logged_in!, only: [:new, :create]

    def show
        rental = CatRentalRequest.find(params[:id])

        render json: rental
    end

    def new
        render :new
    end

    def create
        rental = CatRentalRequest.new(rental_params)
        rental.user_id = current_user.id
        if rental.save
            redirect_to cat_url(rental.cat_id)
        else
            render :new
        end
    end

    def approve
        rental = CatRentalRequest.find_by(id: params[:id])
        rental.approve!
        redirect_to cat_url(rental.cat_id)
    end

    def deny
        rental = CatRentalRequest.find_by(id: params[:id])
        rental.deny!
        redirect_to cat_url(rental.cat_id)
    end

    private

    def must_be_logged_in!
        if current_user.nil?
            redirect_to cats_url
        end
    end

    def require_owner!
        user = current_user
        rental = CatRentalRequest.find_by(id: params[:id])
        cat = Cat.find(rental.cat_id)

        if user.nil? || user.id != cat.user_id
            redirect_to cat_url(cat)
        else
            return
        end
    end

    def rental_params
        params.require(:rental).permit(:cat_id, :start_date, :end_date)
    end
end