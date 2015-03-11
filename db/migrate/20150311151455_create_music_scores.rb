class CreateMusicScores < ActiveRecord::Migration
  def change
    create_table :music_scores do |t|
      t.integer :music_id
      t.integer :difficulty
      t.float :level
      t.integer :notes

      t.timestamps
    end
  end
end
