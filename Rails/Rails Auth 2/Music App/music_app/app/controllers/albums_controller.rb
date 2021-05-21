class AlbumsController < ApplicationController
    def new
        @album = Album.new
        @album.band_id = params[:band_id]
        render :new
    end

    def create
        @album = Album.new(album_params)

        if @album.save
            render json: @album
        else
            render :new
        end
    end

    def edit
        @album = Album.find(params[:id])
        render :edit
    end

    def update
        @album = Album.find(params[:id])
        @album.update_attributes!(album_params)
        redirect_to album_url(@album)
    end

    def show
        @album = Album.find(params[:id])
        render :show
    end

    def destroy

    end

    private

    def album_params
        params.require(:album).permit(:name, :year, :live, :band_id)
    end
end