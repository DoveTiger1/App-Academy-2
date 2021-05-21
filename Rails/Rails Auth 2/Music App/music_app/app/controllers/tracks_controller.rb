class TracksController < ApplicationController
    before_action :require_user!

    def new
        @track = Track.new
        @track.album_id = params[:album_id]
        render :new
    end

    def create
        @track = Track.new(track_params)

        if @track.save
            redirect_to track_url(@track)
        else
            render :new
        end
    end

    def edit
        @track = Track.find(params[:id])
        render :edit
    end

    def update
        @track = Track.find(params[:id])
        if @track.update_attributes!(track_params)
            redirect_to track_url(@track)
        else
            render :edit
        end
    end

    def destroy
        @track = Track.find(params[:id])
        album_id = @track.album_id
        @track.destroy
        redirect_to album_url(album_id)
    end

    def show
        @track = Track.find(params[:id])
        render :show
    end

    private

    def track_params
        params.require(:track).permit(:title, :album_id, :ord, :lyrics, :is_bonus)
    end
end