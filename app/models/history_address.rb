class HistoryAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :city
    validates :address
    validates :prefecture_id, numericality: { other_than: 1, message: "を選択して下さい" }
    validates :phone_number,  numericality: {only_integer: true, less_than_or_equal_to: 99999999999}
    validates :user_id
    validates :item_id
  end

  def save
    purchase_history = PurchaseHistory.create(item_id: item_id, user_id: user_id)
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number, purchase_history_id: purchase_history.id)
  end
end