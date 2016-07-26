class AddSynopsisToAdventure < ActiveRecord::Migration[5.0]
  def change
    add_column :adventures, :synopsis, :string
  end
end
