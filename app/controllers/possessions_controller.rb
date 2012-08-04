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
  end

  def update
  end

  def destroy
  end
end
