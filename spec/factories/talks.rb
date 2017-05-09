FactoryGirl.define do
  factory :talk do
    sequence(:title) { |n| 'Title %02d'%[n] }
    sequence(:subtitle) { |n| 'Subtitle %02d'%[n] }
    sequence(:videos) { |n| (0..n).map { |e| 'http://example.com/video/%02d'%[e] } }
    sequence(:url) { |n| '%02d'%[n] }
    sequence(:slides) { |n| '%02d'%[n] }
    sequence(:date) { |n| '%02d'%[n] }
  end
end
