class CollectionsController < ApplicationController
    def index
        user = User.find(params[:user_id])
        render json: user.collections
    end

    def add_artwork
        artwork_collection = ArtworksCollection.new(artwork_id: params[:artwork_id], collection_id: params[:collection_id])

        if artwork_collection.save
            render json: Collection.find(params[:collection_id]).artworks
        else
            render json: artwork_collection.errors.full_messages, status: :unprocessable_entity
        end
    end

    def remove_artwork
        artwork_collection = ArtworksCollection.find_by(artwork_id: params[:artwork_id], collection_id: params[:collection_id])
        artwork_collection.destroy
        render json: Collection.find(params[:collection_id]).artworks
    end

    def create
        collection = Collection.new(collection_params)

        if collection.save
            render json: collection
        else
            render json: collection.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        collection = Collection.find(params[:id])
        render json: collection
    end

    def destroy
        collection = Collection.find(params[:id])
        collection.destroy
        render json: collection
    end

    private

    def collection_params
        params.require(:collection).permit(:name, :user_id)
    end
end