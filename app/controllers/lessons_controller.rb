# frozen_string_literal: true

class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[show update destroy]
  before_action :set_course

  def index
    @lessons = Lesson.where(course_id: params[:course_id])
  end

  def show; end

  def create
    @lesson = Lesson.new(lesson_params.except(:video))
    @lesson.course = @course if @lesson.course_id.nil?

    if @lesson.save
      @lesson.video.attach(params[:lesson][:video]) if lesson_params[:video].present?
      render :show, status: :created
    else
      render json: @lesson.errors, status: :unprocessable_entity
    end
  end

  def update
    if @lesson.update(lesson_params)
      render :show, status: :ok
    else
      render json: @lesson.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @lesson.destroy!
  end

  private

  def set_course
    @course = Course.friendly.find(params[:course_id]) if params[:course_id]
  rescue ActiveRecord::RecordNotFound
    @course = nil
  end

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :description, :course_id, :course_slug, :video)
  end
end
