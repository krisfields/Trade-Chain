class ImagesController < ApplicationController
  def new
  end

  def edit
  end

  def create
    @image = Image.new(params[:image])
    @image.save
    redirect_to possession_path(@image.possession_id)
  end

  def index
  end

  def update
  end
end
