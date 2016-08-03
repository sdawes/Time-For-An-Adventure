class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :chapters
      t.string :choices
      t.references :user, foreign_key: true
      t.references :adventure, foreign_key: true

      t.timestamps
    end
  end
end
