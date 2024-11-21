# frozen_string_literal: true

class CoursesController < ApplicationController
  before_action :set_course, only: %i[show update destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.opened
  end

  # GET /courses/1
  # GET /courses/1.json
  def show; end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params.except(:image))

    if @course.save
      @course.image.attach(course_params[:image]) if course_params[:image].present?
      render :show, status: :created, location: @course
    else
      render json: error_wrapper(@course.errors.full_messages), status: :ok
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    if @course.update(course_params)
      render :show, status: :ok, location: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = if params[:include_lessons] == 'true'
                Course.includes(:lessons).friendly.find(params[:id])
              else
                Course.friendly.find(params[:id])
              end
  end

  # Only allow a list of trusted parameters through.
  def course_params
    params.require(:course).permit(:title, :description, :start_date, :end_date, :image)
  end
end
