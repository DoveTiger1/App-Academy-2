class NotesController < ApplicationController
    before_action :require_user!

    def create
        @note = Note.new(note_params)
        @note.user_id = current_user.id

        @note.save
        redirect_to track_url(@note.track_id)
    end

    def destroy
        @note = Note.find(params[:id])
        track = @note.track_id
        
        if @note.author != current_user
            render text: 'Not allowed to remove another users notes'
        else
            @note.destroy
            redirect_to track_url(track)
        end
    end

    private

    def note_params
        params.require(:note).permit(:body, :track_id)
    end
end