require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end


  describe 'ユーザー新規登録' do
    context 'ユーザ新規登録ができる時' do
      # 値の存在有無による挙動確認
      it 'name、email、password、password_confirmation、last_name、first_name、kana_last_name、kana_first_name、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      # passwordのバリデーション確認 
      it 'passwordは半角英数字混合である場合登録できる' do
        @user.password = '111aaa'
        @user.password_confirmation = '111aaa'
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上であれば登録できる' do
        @user.password = '12345a'
        @user.password_confirmation = '12345a'
        expect(@user).to be_valid
      end
      # 名前のバリデーション確認
      it 'last_nameは全角（漢字、ひらがな、カタカナ）であれば登録できる' do
        @user.last_name = '漢字ひらがなカタカナ'
        expect(@user).to be_valid
      end      
      it 'first_nameは全角（漢字、ひらがな、カタカナ）であれば登録できる' do
        @user.first_name = '漢字ひらがなカタカナ'
        expect(@user).to be_valid
      end
      # 名前（カナ）のバリデーション確認
      it 'kana_last_nameは全角カタカナであれば登録できる' do
        @user.kana_last_name = 'カタカナ'
        expect(@user).to be_valid
      end      
      it 'kana_first_nameは全角カタカナであれば登録できる' do
        @user.kana_first_name = 'カタカナ'
        expect(@user).to be_valid
      end
    end
    
    context 'ユーザ新規登録ができない時' do
      # 値の存在有無による挙動確認
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'passwordが空では登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'last_name が空では登録できないこと' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last nameを入力してください")
      end
      it 'first_nameが空では登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First nameを入力してください")
      end
      it 'kana_last_nameが空では登録できないこと' do
        @user.kana_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana last nameを入力してください")
      end
      it 'kana_first_nameが空では登録できないこと' do
        @user.kana_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first nameを入力してください")
      end
      it 'birthday が空では登録できないこと' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("誕生日を入力してください")
      end
      # emailバリデーション確認
      it 'emailは@を含んでいないと登録できない' do
        @user.email = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it '重複したemailが存在する場合登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      # passwordのバリデーション確認  
      it 'passwordは半角数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて設定してください")
      end
      it 'passwordは半角英のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて設定してください")
      end
      it 'passwordが全角では登録できないこと' do
        @user.password = '１１１ａａａ'
        @user.password_confirmation = '１１１ａａａ'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて設定してください")
      end
      it 'passwordが5文字以下であれば登録できないこと' do
        @user.password = '1234a'
        @user.password_confirmation = '1234a'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = '12345a'
        @user.password_confirmation = '12345a7'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      # 名前のバリデーション確認
      it 'last_nameは半角英数字では登録出来ない' do
        @user.last_name = 'aaa111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last nameは不正な値です")
      end
      it 'first_nameは半角英数字では登録出来ない' do
        @user.first_name = 'aaa111'
        @user.valid?
        expect(@user.errors.full_messages).to include("First nameは不正な値です")
      end
      # 名前（カナ）のバリデーション確認
      it 'kana_last_nameは全角（漢字、ひらがな）では登録できない' do
        @user.kana_last_name = '漢字ひらがな'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana last nameは不正な値です")
      end
      it 'kana_last_nameは半角英数字では登録出来ない' do
        @user.kana_last_name = 'aaa111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana last nameは不正な値です")
      end
      it 'kana_first_nameは全角（漢字、ひらがな）では登録できない' do
        @user.kana_first_name = '漢字ひらがな'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first nameは不正な値です")
      end
      it 'kana_first_nameは半角英数字では登録出来ない' do
        @user.kana_first_name = 'aaa111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first nameは不正な値です")
      end 
    end    
  end  
end

end
