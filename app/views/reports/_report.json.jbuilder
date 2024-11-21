json.id report.id
json.created_at report.created_at
json.updated_at report.updated_at
json.formated_date I18n.l(report.created_at, format: :default)
json.course render partial: 'courses/course', locals: { course: report.course }
json.file report.file.attached? ? report.file.url : nil
