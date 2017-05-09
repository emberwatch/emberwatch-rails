FactoryGirl.define do
  factory :person do
    sequence(:old_id) { |n| n }
    sequence(:shortname) { |n| 'Shortname %02d'%[n] }
    sequence(:name) { |n| 'Name %02d'%[n] }
    sequence(:github) { |n| 'https://github.com/%02d'%[n] }
    sequence(:slack) { |n| '%02d'%[n] }
    sequence(:twitter) { |n| '@%02d'%[n] }
    sequence(:slideshare) { |n| '%02d'%[n] }
    sequence(:speakerdeck) { |n| '%02d'%[n] }
    sequence(:site) { |n| 'http://example.com/person/%02d'%[n] }
    sequence(:company) { |n| 'Company %02d'%[n] }
  end
end
