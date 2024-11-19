# frozen_string_literal: true

class ReportBuilderWorker
  include Sidekiq::Job

  def perform(report_id)
    CourseReport.new(report_id).generate
  end
end
