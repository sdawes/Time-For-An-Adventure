class CreateChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :choices do |t|
      t.string :option
      t.integer :resulting_chapter_id

      t.timestamps
    end
  end
end
