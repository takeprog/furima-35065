class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :product_name 
      t.text :explanation 
      t.integer :category_id
      t.integer :product_status_id
      t.integer :delivery_fee_id 
      t.integer :prefecture_id 
      t.integer :shipping_day_id
      t.integer :price  
      t.references :user, foreign_key: true


      t.timestamps
    end
  end
end
