# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    course
    status { 'pending' }
    lessons_count { 0 }
    lessons_video_count { 0 }
    lessons_video_size_in_megabytes { 0 }
    lessons_video_duration_in_minutes { 0 }
  end
end
