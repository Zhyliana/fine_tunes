class AlbumsController < ApplicationController
  def index
    @albums = Album.all
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
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end  
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])

    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
    end
  end

  def destroy
    @album = Album.find(params[:id])
    
    if @album.try(:destroy)
      redirect_to album_url(@album.band_id)
    else
      flash.now[:errors] = @album.errors.full_messages
    end
  end
  
  private
  def album_params
    params.require(:album).permit(:name, :band_id, :audio)
  end
end
