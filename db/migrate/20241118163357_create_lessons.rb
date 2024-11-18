class CreateLessons < ActiveRecord::Migration[7.1]
  def change
    create_table :lessons do |t|
      t.belongs_to :course, index: true

      t.string :title
      t.string :description
      t.timestamps
    end
  end
end
