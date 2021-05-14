class ArtworksharesController < ApplicationController
    def create
        share = ArtworkShare.new(artwork_share_params)

        if share.save
            render json: share
        else
            render json: share.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        share = ArtworkShare.find(params[:id])
        share.destroy
        render json: share
    end

    def favorite
        share = ArtworkShare.find(params[:id])
        share.favorite = true
        render json: share
    end

    def unfavorite
        share = ArtworkShare.find(params[:id])
        share.favorite = false
        render json: share
    end

    private

    def artwork_share_params
        params.require(:artwork_share).permit(:artwork_id, :viewer_id)
    end
end