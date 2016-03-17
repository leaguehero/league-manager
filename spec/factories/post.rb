FactoryGirl.define do
  sequence :title do |n|
    "Test Post#{n}"
  end
end

FactoryGirl.define do
  factory :post, :class => 'Post' do
    title     
    body      "Just a test post"
  end
end
