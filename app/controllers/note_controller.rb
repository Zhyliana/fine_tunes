class NoteController < ApplicationController
  def index
    @notes = Note.all
  end

  def show
    @note = Note.find(params[:id])
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
  
    if @note.try(:save)
      flash.notice = '"#{@note.name}" has been created.'
      # Below: @note.id or just @note?
      redirect_to note_url(@note.id)
    else
      flash.notice = '"#{@note.name}" could not be saved.'
      render :new
    end  
  end

  def edit
    @note = Note.find(params[:id])
    render :edit
  end

  def update
    @note = Note.find(params[:id])

    if @note.update_attributes(note_params)
      flash.notice = 'Changes to "#{@note.name}" have been saved.'
      redirect_to note_url(@note)
    else
      flash.notice = 'Changes to "#{@note.name}" could NOT be saved.'
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])
    note = Note.find_by_id(@note.note_id)
  
    if @note.try(:destroy)
      flash.notice = '"#{@note.name}" and its albums and tracks have been deleted.'
      # Below: @note.id or just @note?
      redirect_to note_url(@note)
    else
      flash.notice = '"#{@note.name}" and its albums and tracks could NOT be deleted.'
      render :edit
    end
  end

  private

  def note_params
    params.require(:note).permit(:body, :user_id, :track_id)
  end
end
