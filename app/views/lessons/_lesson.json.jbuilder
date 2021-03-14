json.extract! lesson, :id, :name, :description, :video, :course_id, :created_at, :updated_at
json.url lesson_url(lesson, format: :json)
