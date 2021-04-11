class PurchaseHistoriesController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!
  before_action :move_to_index
  before_action :move_to_root
  
  def index
     @history_address=HistoryAddress.new
  end
  
  def create
    @history_address=HistoryAddress.new(history_params)
    if @history_address.valid?
      pay_item
      @history_address.save
      redirect_to root_path
    else
      render :index
    end
  end

private

  def history_params
    params.require(:history_address).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number, :item_id).merge(user_id: current_user.id, item_id:params[:item_id], token: params[:token])
  end

  def move_to_index
    if @item.user_id == current_user.id
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: history_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_root
    unless @item.purchase_history == nil
      redirect_to root_path
    end
  end
   
  def set_item
    @item = Item.find(params[:item_id])
  end
end
