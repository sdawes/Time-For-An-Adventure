class AddParentChoiceIdToChapters < ActiveRecord::Migration[5.0]
  def change
    add_column :chapters, :parent_choice_id, :integer
  end
end
