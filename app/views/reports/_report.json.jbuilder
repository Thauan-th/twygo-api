json.id report.id
json.created_at I18n.l(report.created_at, format: :long)
json.updated_at I18n.l(report.updated_at, format: :long)
json.formated_date I18n.l(report.created_at, format: :long)
json.course render partial: 'courses/course', locals: { course: report.course }
json.file report.file.attached? ? report.file.url : nil
