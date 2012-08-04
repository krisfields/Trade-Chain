class WantsController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy, ]
  
  def index
    @wants = Want.find_by_user_id(current_user.id) || []
    respond_with(@wants)
  end

  def show
    @want = Want.find(params[:id])
    respond_with(@want)
  end

  def new
    @want = Want.new
  end

  def create
    @want = Want.new(params[:want])
    @want.user_id = current_user.id
    if @want.save
      flash[:notice] = "Successfully added! The more items you add, the better your chance of trading!"
      redirect_to new_want_path
    else
      flash[:error] = "Oops.  Your item wasn't added yet.  Please take care of the problems below and resubmit."
      render action: "new"
    end
  end

  def edit
    @want = Want.find(params[:id])
  end

  def update
    @want = Want.find(params[:id])
    if @want.update_attributes(params[:want])
      flash[:notice] = "Successfully updated your item!"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Oops.  Please take care of the problems below before we can update your item."
      render action: "new"
    end
  end

  def destroy
    @want = Want.find(params[:id])
    @want.destroy
    redirect_to user_path(current_user)
  end
end
