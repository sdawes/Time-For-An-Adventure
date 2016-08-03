class AddDestroyToChapters < ActiveRecord::Migration[5.0]
  def change
    add_column :chapters, :to_destroy, :boolean
  end
end
