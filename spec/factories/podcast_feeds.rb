FactoryGirl.define do
  factory :podcast_feed, class: Podcast::Feed do
    sequence(:url) { |n| 'https://%02d.example.com/feed'%[n] }
  end
end
