class CreateMusicScores < ActiveRecord::Migration
  def change
    create_table :music_scores do |t|
      t.references :music, null: false
      t.integer :difficulty, null: false
      t.float :level, null: false
      t.integer :notes, null: false

      t.timestamps null: false
    end
  end

  add_foreign_key :music_scores, :musics
end
