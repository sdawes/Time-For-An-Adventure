class ChangeColumnNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null :choices, :option, false
    change_column_null :choices, :resulting_chapter_id, false
    change_column_null :choices, :chapter_id, false
    change_column_null :chapters, :description, false
    change_column_null :chapters, :adventure_id, false
  end
end
