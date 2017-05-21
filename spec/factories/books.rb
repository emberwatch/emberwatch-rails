FactoryGirl.define do
  factory :book do
    sequence(:title) { |n| 'Title %02d'%[n] }
    sequence(:publisher) { |n| 'Publish %02d'%[n] }
    sequence(:url) { |n| 'http://example.com/book/%02d'%[n] }
    sequence(:payment) { |n| 'Payment %02d'%[n] }
  end
end
