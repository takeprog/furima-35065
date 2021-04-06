FactoryBot.define do
  factory :item do
    product_name      {'オムライス'}
    explanation       {'出来たてアツアツ'}
    category_id       {2}
    product_status_id {2}
    delivery_fee_id   {2}
    prefecture_id     {2}
    shipping_day_id   {2}
    price             {1000}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
    
  end
end
