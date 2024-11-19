# frozen_string_literal: true

class CourseReport
  attr_accessor :report

  def initialize(report_id)
    self.report = Report.find(report_id)
  end

  def generate
    fill_report_fields
    generate_report_file

    report.mark_as_completed
  end

  private

  def fill_report_fields
    attrs = {
      lessons_count: course.lessons.count,
      lessons_video_count: count_attached_videos,
      lessons_video_size_in_megabytes: calculate_attached_videos_size,
      lessons_video_duration_in_minutes: calculate_attached_video_duration
    }

    report.update!(attrs)
  end

  def count_attached_videos
    course.lessons.sum do |lesson|
      lesson.video.attached? ? 1 : 0
    end
  end

  def calculate_attached_videos_size
    result = course.lessons.sum do |lesson|
      lesson.video.attached? ? lesson.video.blob.byte_size : 0
    end

    result / 1.megabyte
  end

  def calculate_attached_video_duration
    0
  end

  def generate_report_file
    # add PRAWN here
  end

  def course
    @course ||= Course.includes(:lessons).find(report.course_id)
  end
end
