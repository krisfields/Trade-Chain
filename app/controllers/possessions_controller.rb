class PossessionsController < ApplicationController
  respond_to :html, :json
  
  def index
    @possessions = Possession.all
    respond_with(@possessions)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
