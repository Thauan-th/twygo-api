require 'rails_helper'

RSpec.describe Reports::Course do
  describe '#initialize' do
    let(:report) { create(:report) }
    let(:pdf_generator) { described_class.new(report.id) }

    it 'assigns the report' do
      expect(pdf_generator.report).to eq(report)
    end

    it 'should raise an error if the report does not exist' do
      expect { described_class.new(0) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#call' do
    let(:course) { create(:course, :with_lessons) }
    let(:report) { create(:report, course: course) }

    def calculate_attached_videos_size(lessons)
      result = lessons.sum do |lesson|
        lesson.video.attached? ? lesson.video.blob.byte_size : 0
      end

      result / 1.megabyte
    end

    subject { described_class.new(report.id) }

    it 'generates a PDF file' do
      expect { subject.call }.to change { report.reload.file.attached? }.from(false).to(true)
    end

    it 'marks the report as completed' do
      subject.call
      expect(report.reload).to be_completed
    end

    it 'updates the report stats' do
      subject.call

      report.reload

      expect(report.lessons_count).to eq(course.lessons.count)
      expect(report.lessons_video_count).to eq(course.lessons.with_attached_video.count)
      expect(report.lessons_video_size_in_megabytes).to eq(calculate_attached_videos_size(report.course.lessons))
    end
  end
end
