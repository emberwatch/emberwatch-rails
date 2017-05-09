FactoryGirl.define do
  factory :event do
    date Time.now
    sequence(:name) { |n| 'Name %02d'%[n] }
    sequence(:site) { |n| 'http://example.com/event/%02d'%[n] }
  end
end
