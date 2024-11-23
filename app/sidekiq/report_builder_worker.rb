# frozen_string_literal: true

class ReportBuilderWorker
  include Sidekiq::Job

  def perform(report_id)
    Reports::Course.new(report_id).call
  end
end
