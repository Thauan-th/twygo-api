json.results do
  json.array! @reports, partial: 'reports/report', as: :report
end
