# frozen_string_literal: true

FactoryBot.define do
  factory :lesson do
    title { Faker::Educator.course_name }
    description { Faker::Lorem.paragraph }
    course
  end
end
