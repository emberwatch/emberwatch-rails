FactoryGirl.define do
  factory :screencast do
    sequence(:title) { |n| 'Title %02d'%[n] }
    sequence(:url) { |n| 'http://example.com/screencast/%02d'%[n] }
    date Time.now
    sequence(:videos) { |n| (0..n).map { |e| 'http://example.com/video/%02d'%[e] } }
    sequence(:series) { |n| 'Series %02d'%[n] }
    sequence(:price) { |n| '$ %02d'%[n] }
    sequence(:subtitle) { |n| 'Subtitle %02d'%[n] }
  end
end
