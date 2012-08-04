class PossessionsController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy, ]
  
  def index
    @possessions = Possession.all
    respond_with(@possessions)
  end

  def show
    @possession = Possession.find(params[:id])
    respond_with(@possession)
  end

  def new
    @possession = Possession.new
  end

  def create
    @possession = Possession.new(params[:possession])
    @possession.user_id = current_user.id
    if @possession.save
      flash[:notice] = "Successfully added! The more items you add, the better your chance of trading!"
      redirect_to new_possession_path
    else
      flash[:error] = "Oops.  Your item wasn't added yet.  Please take care of the problems below and resubmit."
      render action: "new"
    end
  end

  def edit
    @possession = Possession.find(params[:id])
  end

  def update
    @possession = Possession.find(params[:id])
    if @possession.update_attributes(params[:possession])
      flash[:notice] = "Successfully updated your item!"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Oops.  Please take care of the problems below before we can update your item."
      render action: "new"
    end
  end

  def destroy
    @possession = Possession.find(params[:id])
    @possession.destroy
    redirect_to user_path(current_user)
  end
end
