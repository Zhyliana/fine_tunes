class TracksController < ApplicationController
  def index
    @tracks = Track.all
  end

  def show
    @track = Track.find(params[:id])
  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)

    if @track.try(:save)
      #just @track, not @track_id
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end  
  end

  def edit
    @track = Track.find(params[:id])
  end

  def update
    @track = Track.find(params[:id])

    if @track.update_attributes(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])

    if @track.try(:destroy)
      redirect_to album_url(@track.album_id)
    else
      flash.now[:errors] = @track.errors.full_messages
    end
  end

  private
  def track_params
    params.require(:track).permit(:name, :album_id, :lyrics, :featured)
  end
end

