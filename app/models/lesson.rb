# frozen_string_literal: true

class Lesson < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :course
  has_one_attached :video
  validates :title, :description, presence: true
end
