# frozen_string_literal: true

class CourseReportJob
  include Sidekiq::Job

  def perform(course_id)
    Courses::Report.new(course_id).call
  end
end
