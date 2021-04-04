class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :last_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/} #全角かな、カナ、漢字のみ
    validates :first_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/} 
    validates :kana_last_name, format: {with: /\A[ァ-ヶー]+\z/} #全角カナのみ
    validates :kana_first_name, format: {with: /\A[ァ-ヶー]+\z/}
    validates :birthday, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ } #2019-10-04"のような形でのみ
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' 

end
