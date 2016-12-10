class Api::V1::NotesController < BaseApiControllerController
  before_filter :find_project, only: [:show, :update]
  
  def create
    @note = Note.create(params[:note])
		if @note.valid?
		  # change the project state to started
		  (@note.project.notes.count<2 && @note.project.new?) ? @note.start : true
		  render json: @note
		else
      render nothing: true, status: :bad_request
		end
    
  end
end
