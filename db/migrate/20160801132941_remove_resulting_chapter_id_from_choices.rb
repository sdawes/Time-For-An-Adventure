class RemoveResultingChapterIdFromChoices < ActiveRecord::Migration[5.0]
  def change
    remove_column :choices, :resulting_chapter_id, :integer
  end
end
