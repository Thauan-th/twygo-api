# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_course

  def create
    @report = Report.create!(course: @course)

    @report.generate

    render json: { message: 'Report generated', id: @report.id }, status: :created
  end

  def index
    @reports = Report.all
  end

  private

  def set_course
    @course = Course.friendly.find(params[:course_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Course not found' }, status: :not_found
  end
end
