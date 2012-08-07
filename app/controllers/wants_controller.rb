class WantsController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy ]
  
  def index
    @wants = Want.find_by_user_id(current_user.id) || []
    respond_with(@wants)
  end

  def create
    @want = Want.new(params[:want])
    @want.user_id = current_user.id
    if @want.save
       flash[:notice] = "Successfully marked!  Now go add some more items that you'd like!"
       redirect_to possession_path(@want.possession_id)
    else
       flash[:error] = "Oops.  Something went wrong."
       redirect_to possession_path(@want.possession_id)
    end
  end

  def update
    @want = Want.find(params[:id])
    if @want.update_attributes(params[:want])
      flash[:notice] = "Successfully updated your item!"
      redirect_to possession_path(@want.possession_id)
    else
      flash[:error] = "Oops.  Please take care of the problems below before we can update your item."
      redirect_to possession_path(@want.possession_id)
    end
  end

  def destroy
    @want = Want.find(params[:id])
    possession_id = @want.possession_id
    @want.destroy
    redirect_to possession_path(possession_id)
  end
end
