class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :kana_last_name, presence: true
  validates :kana_first_name, presence: true
  validates :birthday, presence: true

  kanji = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/                        #全角かな、カナ、漢字のみ
  validates :last_name, format: { with: kanji }
  validates :first_name, format: { with: kanji }

  kana = /\A[ァ-ヶー－]+\z/                        #全角カナのみ
  validates :kana_last_name, format: { with: kana }
  validates :kana_first_name, format: { with: kana }

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' 


  year_month_day = /\A\d{4}-\d{2}-\d{2}\z/      #2019-10-04"のような形でのみ
  validates :birthday, format: { with: year_month_day }

  

end
