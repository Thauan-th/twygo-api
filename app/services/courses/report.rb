# frozen_string_literal: true

module Courses
  class Report
    attr_accessor :course

    def initialize(course_id)
      self.course = Course.find(course_id)
    end

    def call
      puts 'Prepared to perform an expensive operation'
    end
  end
end
