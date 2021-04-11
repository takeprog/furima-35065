require 'rails_helper'

RSpec.describe HistoryAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @history_address = FactoryBot.build(:history_address, user_id: user.id, item_id: item.id)
  end


  describe '商品購入' do
    context '商品購入ができる時' do
      # 値の存在有無による挙動確認
      it 'postal_code,prefecture_id,city,address,phone_number,tokenが存在すれば登録できる' do
        expect(@history_address).to be_valid
      end
      # phone_numberのバリデーション確認 
      it 'phone_numberは11桁以内の数値であれば登録できる' do
        @history_address.phone_number = '11111111111'
        expect(@history_address).to be_valid
      end
      # postal_codeのバリデーション確認 
      it 'postal_codeはハイフンが含まれていれば登録できる' do
        @history_address.postal_code = '123-4567'
        expect(@history_address).to be_valid
      end
      # buildingのバリデーション確認 
      it 'buildingが空でも登録できる' do
        @history_address.building = ''
        expect(@history_address).to be_valid
      end
    end
      
    context '商品購入ができない時' do
       # 値の存在有無による挙動確認
       it 'item_idが空だと登録できないこと' do
        @history_address.item_id = ''
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("Itemを入力してください")
      end
      it 'user_idが空だと登録できないこと' do
        @history_address.user_id = ''
        @history_address.valid?
        binding.pry
        expect(@history_address.errors.full_messages).to include("Userを入力してください")
      end
      it 'postal_codeが空では登録できない' do
        @history_address.postal_code = ''
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("Postal codeを入力してください")
      end
      it 'prefecture_idが空では登録できない' do
        @history_address.prefecture_id = ''
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("Prefectureを入力してください")
      end
      it ' cityが空では登録できないこと' do
        @history_address.city = ''
        @history_address.valid?    
        expect(@history_address.errors.full_messages).to include("Cityを入力してください")
      end
      it 'addressが空では登録できないこと' do
        @history_address.address = ''
        @history_address.valid? 
        expect(@history_address.errors.full_messages).to include("Addressを入力してください")
      end
      it 'phone_numberが空では登録できないこと' do
        @history_address.phone_number = ''
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("Phone numberを入力してください")
      end
      it 'tokenが空では登録できないこと' do
        @history_address.token = nil
        @history_address.valid? 
        expect(@history_address.errors.full_messages).to include("Tokenを入力してください")
      end
      # phone_numberのバリデーション確認 
      it 'phone_numberは12桁以上では登録できない' do
        @history_address.phone_number = '111111111111'
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("Phone numberは99999999999以下の値にしてください")
      end
      it 'phone_numberは数字以外は入力できない' do
        @history_address.phone_number = '111-111-111'
        @history_address.valid? 
        expect(@history_address.errors.full_messages).to include("Phone numberは数値で入力してください")
      end
      # postal_codeのバリデーション確認 
      it 'postal_codeはハイフンが含まれない場合は登録できない' do
        @history_address.postal_code = 1234567
        @history_address.valid? 
        expect(@history_address.errors.full_messages).to include("Postal codeは不正な値です")
      end
       # prefecture_idのバリデーション確認 
      it 'prefecture_idは「--」を選択したままでは登録できない' do
        @history_address.prefecture_id = 1
        @history_address.valid?
        expect(@history_address.errors.full_messages).to include("Prefectureを選択して下さい")
      end
    end 
  end  
end
