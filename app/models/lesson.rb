# frozen_string_literal: true

class Lesson < ApplicationRecord
  belongs_to :course
  has_one_attached :video
  validates :title, :description, presence: true
end
