class PurchaseHistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index
  
  def index
     @item = Item.find(params[:item_id])
     @history_address=HistoryAddress.new
  end
  
  def create
    @item = Item.find(params[:item_id])
    @history_address=HistoryAddress.new(history_params)
    if @history_address.valid?
      @history_address.save
      redirect_to root_path
    else
      render :index
    end
  end

private

  def history_params
    params.require(:history_address).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number, :item_id).merge(user_id: current_user.id, item_id:params[:item_id])
  end

  def move_to_index
    if Item.find(params[:item_id]).user_id == current_user.id
      redirect_to root_path
    end
  end
   
end
