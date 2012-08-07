class TradesController < ApplicationController
  def new
    @trade = Trade.new
  end

  def create
    @trade = Trade.new(params[:trade])
    @trade.user_id = current_user.id
    if @trade.save
      flash[:notice] = "New Trade Added"
      redirect_to trade_path(@trade)
    else
      flash[:error] = "Please take care of the problems below."
      render action: "new"
    end
  end

  def index
    @trades = Trade.all
  end

  def edit
    @trade = Trade.find(params[:id])
  end

  def update
    @trade = Trade.find(params[:id])
    if @trade.update_attributes(params[:trade])
      flash[:notice] = "Successfully updated!"
      redirect_to trade_path(@trade)
    else
      flash[:error] = "Something went wrong :(  Please take care of the problems below."
      render action: "edit"  
    end
  end

  def destroy
    @trade = Trade.find(params[:id])
    @trade.destroy
    redirect_to user_path(current_user)
  end

  def show
    @trade = Trade.find(params[:id])
  end

  def results
    @trade = Trade.find(params[:id])
    get_results = @trade.get_results
    @results = @trade.possessions.find_all {|possession| possession.new_owner != nil}
  end
end
