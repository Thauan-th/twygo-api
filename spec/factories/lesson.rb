# frozen_string_literal: true

FactoryBot.define do
  factory :lesson do
    title { Faker::Educator.course_name }
    description { Faker::Lorem.paragraph }
    course
    video { Rack::Test::UploadedFile.new(Rails.root.join('lib', 'assets', 'ruby_lesson.mp4')) }
  end
end
