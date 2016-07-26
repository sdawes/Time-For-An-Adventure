class AddAdventureToChapter < ActiveRecord::Migration[5.0]
  def change
    add_reference :chapters, :adventure, foreign_key: true
  end
end
