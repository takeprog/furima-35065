FactoryBot.define do
  factory :history_address do
    postal_code   {'999-9999'}
    prefecture_id {2}
    city          {'横浜市緑区'}
    address       {'青山1-1'}
    building      {'柳ビル'}
    phone_number  {12345678912}
  end
end
