# frozen_string_literal: true

class Course < ApplicationRecord
  has_many :lessons, dependent: :destroy
  validates :name, :description, presence: true
end
