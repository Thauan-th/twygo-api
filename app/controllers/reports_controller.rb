# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_course

  def create
    report = Report.create!(course: @course)

    report.generate

    render json: { message: 'Report will be available soon', report_id: report.id }, status: :ok
  end

  def index
    @reports = Report.all
  end

  private

  def set_course
    @course = Course.friendly.find(params[:course_id])
  end
end
