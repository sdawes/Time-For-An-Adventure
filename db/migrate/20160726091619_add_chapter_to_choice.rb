class AddChapterToChoice < ActiveRecord::Migration[5.0]
  def change
    add_reference :choices, :chapter, foreign_key: true
  end
end
