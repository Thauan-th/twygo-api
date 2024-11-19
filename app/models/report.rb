# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :course

  validates :status, presence: true, inclusion: { in: %w[pending completed] }

  has_one_attached :file

  def generate
    ReportBuilderWorker.perform_async(id)
  end

  def completed?
    status == 'completed'
  end

  def pending?
    status == 'pending'
  end

  def mark_as_completed
    update!(status: 'completed')
  end
end
