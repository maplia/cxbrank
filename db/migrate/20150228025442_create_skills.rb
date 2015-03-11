class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.integer :user_id, null: false
      t.integer :music_id, null: false
      t.string :comment
      t.integer :best_difficulty, default: 0
      t.float :best_rp, default: 0.00

      t.timestamps
    end
  end
end
