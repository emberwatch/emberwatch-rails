FactoryGirl.define do
  factory :tutorial do
    sequence(:title) { |n| 'Title %02d'%[n] }
    urls ['http://example.com/']
    date 1.day.ago
    sequence(:code) { |n| 'code %02d'%[n] }
    date_updated 1.minute.ago
    date_created 1.hour.ago
  end
end
