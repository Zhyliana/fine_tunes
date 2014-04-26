class AlbumsController < ApplicationController
  def index
    # if params[[:band][:id]].present
    #   "<h1>auudy</h1>".html_safe
    # else
      @albums = Album.all
    # end
  end

  def show
    @album = Album.find(params[:id]) 
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    
    if @album.try(:save)
      flash.notice = '"#{@album.name}" has been added to "#{Band.find_by_id(@album.band_id).name}"s discography.'
      # Below: @album.id or just @album?
      redirect_to album_url(@album)
    else
      flash.notice = '"#{@album.name}" could not be saved to "#{Band.find_by_id(@album.band_id).name}"s discography.'
      render :new
    end  
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])

    if @album.update_attributes(album_params)
      flash.notice = 'Changes to "#{@album.name}" have been saved.'
      redirect_to album_url(@album)
    else
      flash.notice = 'Changes to "#{@album.name}" could NOT be saved.'
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    band = Band.find_by_id(@album.band_id)
    
    if @album.try(:destroy)
      flash.notice = '"#{@album.name}" and its tracks have been deleted from "#{Band.find_by_id(@album.band_id).name}"s discography.'
      # Below: @album.id or just @album?
      redirect_to album_url(@album)
    else
      flash.notice = '"#{@album.name}" could not be deleted from "#{Band.find_by_id(@album.band_id).name}"s discography.'
      render :edit
    end
  end
  
  private

  def album_params
    params.require(:album).permit(:name, :band_id, :audio)
  end
end
