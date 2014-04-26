class BandsController < ApplicationController
  def index
    @bands = Band.all
  end

  def show
    @band = Band.find(params[:id])
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    
    if @band.try(:save)
      flash.notice = '"#{@band.name}" has been created.'
      # Below: @band.id or just @band?
      redirect_to band_url(@band.id)
    else
      flash.notice = '"#{@band.name}" could not be saved.'
      render :new
    end  
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])

    if @band.update_attributes(band_params)
      flash.notice = 'Changes to "#{@band.name}" have been saved.'
      redirect_to band_url(@band)
    else
      flash.notice = 'Changes to "#{@band.name}" could NOT be saved.'
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    band = Band.find_by_id(@band.band_id)
    
    if @band.try(:destroy)
      flash.notice = '"#{@band.name}" and its albums and tracks have been deleted.'
      # Below: @band.id or just @band?
      redirect_to band_url(@band)
    else
      flash.notice = '"#{@band.name}" and its albums and tracks could NOT be deleted.'
      render :edit
    end
  end
  
  private

  def band_params
    params.require(:band).permit(:name)
  end
end
