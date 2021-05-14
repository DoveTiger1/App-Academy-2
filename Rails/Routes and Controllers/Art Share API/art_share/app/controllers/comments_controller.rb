class CommentsController < ApplicationController
    def create
        comment = Comment.new(comment_params)

        if comment.save
            render json: comment
        else
            render json: comment.users.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        comment = Comment.find(params[:id])
        comment.destroy
        render json: comment
    end

    def index
        case
        when params[:author_id]
            comments = Comment.where(author_id: params[:author_id])
        when params[:artwork_id]
            comments = Comment.where(artwork_id: params[:artwork_id])
        else
            comments = Comment.all
        end

        render json: comments
    end

    def like
        like = Like.new({user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Comment'})

        if like.save
            render json: like
        else
            render json: like.errors.full_messages, status: :unprocessable_entity
        end

    end

    def unlike
        like = Like.find_by(user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Comment')
        like.destroy
        render json: like
    end

    private

    def comment_params
        params.require(:comment).require(:body, :author_id, :artwork_id)
    end
end