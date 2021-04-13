class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :move_to_root, only: [:edit, :update, :destroy]

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
    @comment=Comment.new
    @comments = @item.comments.includes(:user)
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to  root_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private
  def item_params
    params.require(:item).permit(:image, :product_name, :explanation, :category_id, :product_status_id, :delivery_fee_id, :prefecture_id, :shipping_day_id, :price).merge(user_id: current_user.id)
  end

  def move_to_index
    unless @item.user_id == current_user.id
      redirect_to action: :index
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_root
    unless @item.purchase_history == nil
      redirect_to root_path
    end
  end

end
