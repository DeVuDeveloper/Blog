FactoryBot.define do
  factory :post do
    author_id { 1 }
    title { 'MyString' }
    text { 'MyText' }
    likes_counter { 1 }
    comments_counter { 1 }
  end
end
