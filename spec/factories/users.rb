FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| 'user%02d@example.com'%[n] }
  end

  factory :admin, class: User do
    sequence(:email) { |n| 'admin%02d@example.com'%[n] }
    after(:build) { |user| user.add_role(:admin) }
  end
end
