# frozen_string_literal: true

course = Course.create!(
  title: 'Ruby on Rails',
  description: 'Learn how to build web applications using Ruby on Rails'
)

lessons = [
  {
    title: 'Aprendendo sobre Rails',
    description: 'Introdução ao Ruby on Rails'
  },
  {
    title: 'Aprofundando em Rails',
    description: 'Aprofundando em Ruby on Rails'
  }
]

lessons.each do |lesson|
  l = Lesson.new(lesson)
  l.course = course
  l.save!

  l.video.attach(
    io: File.open(Rails.root.join('lib', 'assets', 'ruby_lesson.mp4')),
    filename: 'video.mp4',
    content_type: 'video/mp4'
  )
end
