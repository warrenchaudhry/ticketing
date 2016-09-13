require 'faker'
FactoryGirl.define do
  factory :user do
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    email                 { Faker::Internet.email }
    password              'password123'
    password_confirmation 'password123'
    role					        'customer'

    trait :invalid do
      first_name            nil
      last_name             nil
      password              'password123'
      password_confirmation 'password456'
    end

    trait :admin do
      first_name            { Faker::Name.first_name }
      last_name             { Faker::Name.last_name }
      email                 { Faker::Internet.email }
      role                  'admin'
    end

    trait :agent do
      first_name            { Faker::Name.first_name }
      last_name             { Faker::Name.last_name }
      email                 { Faker::Internet.email }
      role                  'agent'
    end
  end

end
