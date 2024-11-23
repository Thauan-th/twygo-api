json.extract! course, :id, :title, :description, :slug
json.created_at I18n.l(course.created_at, format: :default)
json.updated_at I18n.l(course.updated_at, format: :default)

json.start_date I18n.l(course.start_date, format: :default)
json.end_date course.end_date.present? ? I18n.l(course.end_date, format: :default) : nil

json.image course.image.attached? ? course.image.url : nil

if params[:include_lessons] == 'true'
  json.lessons course.lessons do |lesson|
    json.extract! lesson, :id, :title, :description, :slug
    json.created_at I18n.l(lesson.created_at, format: :default)
    json.updated_at I18n.l(lesson.updated_at, format: :default)
    json.video_url lesson.video.attached? ? lesson.video.url : nil
  end
end
