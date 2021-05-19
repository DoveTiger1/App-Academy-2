class BandsController < ApplicationController
    def index
        @bands = Band.all
        render :index
    end

    def new
        @band = Band.new
        render :new
    end

    def create
        @band = Band.new(band_params)

        if @band.save
            render band_url(@band)
        else
            render :new
        end
    end

    def show
        @band = Band.find(params[:id])
        render :show
    end

    def edit
        @band = Band.find(params[:id])
        render :edit
    end

    def update
        @band = Band.find(params[:id])
        @band.update_attributes!(band_params)
        render :show
    end

    def destroy
        @band = Band.find(params[:id])
        @band.destroy
        redirect_to bands_url
    end

    private

    def band_params
        params.require(:band).permit(:name)
    end
end