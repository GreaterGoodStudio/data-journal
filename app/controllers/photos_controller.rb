class PhotosController < ApplicationController
  before_action :find_photo

  def destroy
    if @photo.destroy
      flash[:notice] = "Photo was deleted."
    else
      flash[:error] = "Problem deleting photo."
    end

    redirect_to @photo.photographable
  end

  def download
    data = open(@photo.image_url).read
    send_data data, disposition: "attachment", filename: @photo.image.file.filename
  end

  private

    def find_photo
      return unless params[:id].present?

      @photo = Photo.find(params[:id])
      @project ||= @photo.try(:project)

      authorize @photo
    end
end
