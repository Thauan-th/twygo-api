# frozen_string_literal: true

class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :lessons, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_one_attached :image

  validates :title, :description, presence: true
  validates :start_date, presence: true
  validate :end_date_after_start_date, if: -> { start_date.present? && end_date.present? }

  scope :opened, -> { where(end_date: nil).or(where('end_date > ?', Time.current)) }

  private

  def end_date_after_start_date
    errors.add(:base, 'The end_date should be after the start_date') if end_date < start_date
  end
end
