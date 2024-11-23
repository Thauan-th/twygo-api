# frozen_string_literal: true

module Reports
  class Course < Base
    def call
      report_stats

      generate_and_save_pdf

      report.mark_as_completed!
    end

    private

    def generate_and_save_pdf
      PdfGenerator.new(report.id).generate_and_save_pdf
    end

    def report_stats
      attrs = {
        lessons_count: lessons.count,
        lessons_video_count: count_attached_videos,
        lessons_video_size_in_megabytes: calculate_attached_videos_size,
        lessons_video_duration_in_minutes: calculate_attached_video_duration
      }

      report.update!(attrs)
    end

    def count_attached_videos
      lessons.sum do |lesson|
        lesson.video.attached? ? 1 : 0
      end
    end

    def calculate_attached_videos_size
      result = lessons.sum do |lesson|
        lesson.video.attached? ? lesson.video.blob.byte_size : 0
      end

      result / 1.megabyte
    end

    def calculate_attached_video_duration
      0
    end
  end
end
