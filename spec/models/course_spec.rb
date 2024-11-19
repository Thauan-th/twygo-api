# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  it 'should have a valid factory' do
    expect(build(:course)).to be_valid
  end

  describe 'validations' do
    it 'should be invalid without a title' do
      expect(build(:course, title: nil)).to_not be_valid
    end

    it 'should be invalid without a description' do
      expect(build(:course, description: nil)).to_not be_valid
    end

    it 'should be invalid without a start_date' do
      expect(build(:course, start_date: nil)).to_not be_valid
    end

    it 'should be invalid if end_date is before start_date' do
      expect(build(:course, start_date: Date.today, end_date: Date.yesterday)).to_not be_valid
    end
  end

  describe 'associations' do
    it 'should have many lessons' do
      expect(Course.reflect_on_association(:lessons).macro).to eq(:has_many)
    end

    it 'should destroy associated lessons' do
      course = create(:course)
      create(:lesson, course: course)

      expect { course.destroy }.to change { Lesson.count }.by(-1)
    end
  end

  describe 'scopes' do
    describe 'opened' do
      before do
        create(:course, end_date: nil)
        create(:course, start_date: Date.yesterday - 1.day, end_date: Date.yesterday)
        create(:course, start_date: Date.yesterday, end_date: Date.yesterday)
      end

      it 'should return courses with end_date nil or greater than current time' do
        expect(Course.opened).to eq([Course.first])
      end
    end
  end
end
