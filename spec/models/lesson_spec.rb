# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it 'should have a valid factory' do
    expect(build(:lesson)).to be_valid
  end

  describe 'validations' do
    it 'should be invalid without a title' do
      expect(build(:lesson, title: nil)).to_not be_valid
    end

    it 'should be invalid without a description' do
      expect(build(:lesson, description: nil)).to_not be_valid
    end
  end

  describe 'associations' do
    it 'should belong to a course' do
      expect(Lesson.reflect_on_association(:course).macro).to eq(:belongs_to)
    end

    it 'should have one attached video' do
      should have_one_attached(:video)
    end
  end
end
