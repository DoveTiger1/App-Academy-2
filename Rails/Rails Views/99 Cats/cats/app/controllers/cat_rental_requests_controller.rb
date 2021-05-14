class CatRentalRequestsController < ApplicationController
    def show
        rental = CatRentalRequest.find(params[:id])

        render json: rental
    end

    def new
        render :new
    end

    def create
        rental = CatRentalRequest.new(rental_params)

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

    end

    private

    def rental_params
        params.require(:rental).permit(:cat_id, :start_date, :end_date)
    end
end