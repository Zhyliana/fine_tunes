class TracksController < ApplicationController
  def index
    @tracks = Track.all
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)

    if @track.try(:save)
      flash.notice = '"#{@track.name}" has been created.'
      # Below: @track.id or just @track?
      redirect_to track_url(@track.id)
    else
      flash.notice = '"#{@track.name}" could not be saved.'
      render :new
    end  
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])

    if @track.update_attributes(track_params)
      flash.notice = 'Changes to "#{@track.name}" have been saved.'
      redirect_to track_url(@track)
    else
      flash.notice = 'Changes to "#{@track.name}" could NOT be saved.'
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    track = Track.find_by_id(@track.track_id)

    if @track.try(:destroy)
      flash.notice = '"#{@track.name}" has been deleted.'
      # Below: @track.id or just @track?
      redirect_to track_url(track)
    else
      flash.notice = '"#{@track.name}" has been deleted.'
      render :edit
    end
  end

  private

  def track_params
    params.require(:track).permit(:name, :album_id, :lyrics, :field)
  end
end

