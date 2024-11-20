json.extract! course, :id, :created_at, :updated_at, :title, :description, :slug
json.start_date I18n.l(course.start_date, format: :default)
json.end_date course.end_date.present? ? I18n.l(course.end_date, format: :default) : nil

json.image course.image.attached? ? course.image.url : nil

if params[:include_lessons] == 'true'
  json.lessons course.lessons do |lesson|
    json.extract! lesson, :id, :title, :description, :slug, :created_at, :updated_at
    json.video lesson.video.attached? ? lesson.video.url : nil
  end
end
