require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end


  describe '商品出品' do
    context '商品出品ができる時' do
      # 値の存在有無による挙動確認
      it 'product_name,explanation,category_id,product_status_id,delivery_fee_id,prefecture_id,shipping_day_id,priceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
      # priceのバリデーション確認 
      it 'priceは半角数字であれば登録できる' do
        @item.price = 1000
        expect(@item).to be_valid
      end
      it 'priceが¥300~¥9,999,999であれば登録できる' do
        @item.price = 300
        expect(@item).to be_valid
      end
    end
      
    context '商品出品ができない時' do
      # 値の存在有無による挙動確認
      it 'product_nameが空では登録できない' do
        @item.product_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product nameを入力してください")
      end
      it 'explanation が空では登録できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanationを入力してください")
      end
      it ' category_idが空では登録できないこと' do
        @item.category_id = ''
        @item.valid?    
        expect(@item.errors.full_messages).to include("Categoryを選択して下さい")
      end
      it 'product_status_id が空では登録できないこと' do
        @item.product_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product statusを選択して下さい")
      end
      it 'delivery_fee_idが空では登録できないこと' do
        @item.delivery_fee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery feeを選択して下さい")
      end
      it 'prefecture_idが空では登録できないこと' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefectureを選択して下さい")
      end
      it 'shipping_day_idが空では登録できないこと' do
        @item.shipping_day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping dayを選択して下さい")
      end
      it 'priceが空では登録できないこと' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Priceを入力してください")
      end
      it 'imageが空では登録できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Imageを入力してください")
      end
      # priceバリデーション確認
      it 'priceは全角では登録できない' do
        @item.price = '１０００'
        @item.valid? 
        expect(@item.errors.full_messages).to include("Priceは数値で入力してください")
      end


      it 'priceは¥300未満では登録出来ない' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include('Priceは300以上の値にしてください')
      end
      it 'priceは¥10,000,000以上では登録できない' do
        @item.price=100000000
        @item.valid?
        expect(@item.errors.full_messages).to include('Priceは9999999以下の値にしてください')
      end
      # アクティブハッシュのバリデーション確認  
      it 'category_idは「--」を選択したままでは登録できない' do
        @item.category_id = 1
        @item.valid?     
        expect(@item.errors.full_messages).to include("Categoryを選択して下さい")
      end
      it 'product_status_idは「--」を選択したままでは登録できない' do
        @item.product_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Product statusを選択して下さい")
      end
      it 'delivery_fee_idは「--」を選択したままでは登録できない' do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery feeを選択して下さい")
      end
      it 'prefecture_id は「--」を選択したままでは登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefectureを選択して下さい")
      end
      it 'shipping_day_idは「--」を選択したままでは登録できない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping dayを選択して下さい")
      end

    end 

  end  
  
end
