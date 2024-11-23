# frozen_string_literal: true

module Reports
  class Base
    attr_accessor :report

    def initialize(report_id)
      self.report = ::Report.find(report_id)
    end

    private

    def lessons
      @lessons ||= course.lessons
    end

    def course
      @course ||= ::Course.includes(:lessons).find(report.course_id)
    end
  end
end
