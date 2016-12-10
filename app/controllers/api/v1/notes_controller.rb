class Api::V1::NotesController < BaseApiControllerController
  before_filter :find_note
  
  def create
		if @note.valid?
		  # change the project state to started
		  (@note.project.notes.count<2 && @note.project.new?) ? @note.start : true
		  render json: @note
		else
      render nothing: true, status: :bad_request
		end
    
  end
  
  def destroy
    @note.delete
    if @note.save
        render json: @note
    else
        render nothing: true, status: :bad_request
    end
  end
  
  private
  def find_note
    @note = Note.create(params[:note])
  end
end
