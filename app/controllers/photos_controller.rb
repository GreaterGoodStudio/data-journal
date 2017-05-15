class PhotosController < ApplicationController
  before_action :find_photo

  def index
    @photos = @session.photos
    render layout: "modal"
  end

  def show; end

  def destroy
    if @photo.destroy
      flash[:notice] = "Photo was deleted."
    else
      flash[:error] = "Problem deleting photo."
    end

    redirect_to @photo.photographable
  end

  private
  
    def find_photo
      @photo = Photo.find(params[:id]) if params[:id]
    end
end
