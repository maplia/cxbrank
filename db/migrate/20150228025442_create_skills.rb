class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.integer :user_id, :null => false
      t.integer :music_id, :null => false
      t.integer :difficulty1_status
      t.boolean :difficulty1_locked
      t.integer :difficulty1_rate
      t.float :difficulty1_rp
      t.integer :difficulty1_grade
      t.integer :difficulty1_combo
      t.boolean :difficulty1_ultimate
      t.integer :difficulty1_score
      t.integer :difficulty2_status
      t.boolean :difficulty2_locked
      t.integer :difficulty2_rate
      t.float :difficulty2_rp
      t.integer :difficulty2_grade
      t.integer :difficulty2_combo
      t.boolean :difficulty2_ultimate
      t.integer :difficulty2_score
      t.integer :difficulty3_status
      t.boolean :difficulty3_locked
      t.integer :difficulty3_rate
      t.float :difficulty3_rp
      t.integer :difficulty3_grade
      t.integer :difficulty3_combo
      t.boolean :difficulty3_ultimate
      t.integer :difficulty3_score
      t.integer :difficulty4_status
      t.boolean :difficulty4_locked
      t.integer :difficulty4_rate
      t.float :difficulty4_rp
      t.integer :difficulty4_grade
      t.integer :difficulty4_combo
      t.boolean :difficulty4_ultimate
      t.integer :difficulty4_score
      t.integer :difficulty5_status
      t.boolean :difficulty5_locked
      t.integer :difficulty5_rate
      t.float :difficulty5_rp
      t.integer :difficulty5_grade
      t.integer :difficulty5_combo
      t.boolean :difficulty5_ultimate
      t.integer :difficulty5_score
      t.string :comment
      t.integer :best_difficulty
      t.float :best_rp

      t.timestamps
    end
  end
end
