FactoryBot.define do
  factory :user do
    nickname              {'aaa'}
    email                 {Faker::Internet.free_email}
    password              {'aa00AA'}
    password_confirmation {password}
    last_name             {'山田'}
    first_name            {'太郎'}
    kana_last_name        {'ヤマダ'}
    kana_first_name       {'タロウ'}
    birthday              {'2000-01-01'}

  end
end