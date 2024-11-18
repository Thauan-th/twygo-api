json.extract! course, :id, :created_at, :updated_at, :title, :description
json.url course_url(course, format: :json)
