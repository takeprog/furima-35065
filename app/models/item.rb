class Item < ApplicationRecord
 


  belongs_to :user
  has_one_attached :image
  has_one :purchase_history

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :product_status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :shipping_day

  with_options presence: true do
    validates :product_name 
    validates :explanation
    validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
    validates :image
  end

  with_options numericality: { other_than: 1, message: "を選択して下さい" } do 
    validates :category_id 
    validates :product_status_id
    validates :delivery_fee_id 
    validates :prefecture_id
    validates :shipping_day_id
  end
end
