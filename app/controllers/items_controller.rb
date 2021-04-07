class ItemsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :move_to_index, only: :edit

  def index
    @items=Item.all.order("created_at DESC")
  end
  
  def new
    @item=Item.new
  end

  def create
    @item=Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item=Item.find(params[:id])
  end

  def edit
    @item=Item.find(params[:id])
  end

  def update
    @item=Item.find(params[:id])
    if @item.update(item_params)
      redirect_to  root_path
    else
      render :edit
    end
 
  end

  private
  def item_params
    params.require(:item).permit(:image, :product_name, :explanation, :category_id, :product_status_id, :delivery_fee_id, :prefecture_id, :shipping_day_id, :price).merge(user_id: current_user.id)
  end

  def move_to_index
    unless Item.find(params[:id]).user_id == current_user.id
      redirect_to action: :index
    end
  end

end
