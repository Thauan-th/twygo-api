# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[7.1]
  def change
    create_table :reports do |t|
      t.references :course, null: false, foreign_key: true
      t.string :status, null: false, default: 'pending'
      t.integer :lessons_count, null: false, default: 0
      t.integer :lessons_video_count, null: false, default: 0
      t.decimal :lessons_video_size_in_megabytes, null: false, default: 0

      t.timestamps
    end
  end
end
