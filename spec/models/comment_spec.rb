require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    sleep 0.1
    @comments = FactoryBot.build(:comment, user_id: user.id, item_id: item.id)
  end

  describe 'コメント機能' do
    context 'コメントができる時' do
      # 値の存在有無による挙動確認
      it 'text,user_id,item_idが存在すれば登録できる' do
        expect(@comments).to be_valid
      end
    end
      
    context 'コメントができない時' do
       # 値の存在有無による挙動確認
       it 'textが空だと登録できないこと' do
        @comments.text = ''
        @comments.valid?
        expect(@comments.errors.full_messages).to include("Textを入力してください")
      end
      it 'user_idが空だと登録できないこと' do
        @comments.user_id = ''
        @comments.valid?
        expect(@comments.errors.full_messages).to include("Userを入力してください")
      end
      it 'postal_codeが空では登録できない' do
        @comments.item_id = ''
        @comments.valid?
        expect(@comments.errors.full_messages).to include("Itemを入力してください")
      end
    end 
  end  
end
