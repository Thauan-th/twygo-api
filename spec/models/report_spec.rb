# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Report, type: :model do
  it 'has a valid factory' do
    expect(build(:report)).to be_valid
  end

  it 'is invalid without a status' do
    expect(build(:report, status: nil)).to be_invalid
  end

  it 'is invalid with a status other than pending or completed' do
    expect(build(:report, status: 'invalid')).to be_invalid
  end
end
