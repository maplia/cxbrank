class CreateMusicScores < ActiveRecord::Migration
  def change
    create_table :music_scores do |t|
      t.integer :music_id, null: false
      t.integer :difficulty, null: false
      t.float :level, null: false
      t.integer :notes, null: false

      t.timestamps
    end
  end
end
