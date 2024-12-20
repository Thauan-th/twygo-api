# frozen_string_literal: true

class CoursesController < ApplicationController
  before_action :set_course, only: %i[show update destroy]

  def index
    @courses = Course.opened
  end

  def show; end

  def create
    @course = Course.new(course_params.except(:image))

    if @course.save
      @course.image.attach(course_params[:image]) if course_params[:image].present?
      render :show, status: :created, location: @course
    else
      render json: error_wrapper(@course.errors.full_messages), status: :ok
    end
  end

  def update
    if @course.update(course_params.except(:image))
      if course_params[:image].present?
        @course.image.attach(course_params[:image])
      elsif @course.image.attached?
        @course.image.purge
      end

      render :show, status: :ok, location: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy!
  end

  private

  def set_course
    @course = if params[:include_lessons] == 'true'
                Course.includes(:lessons).friendly.find(params[:id])
              else
                Course.friendly.find(params[:id])
              end
  end

  def course_params
    params.require(:course).permit(:title, :description, :start_date, :end_date, :image)
  end
end
