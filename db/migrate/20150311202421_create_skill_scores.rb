class CreateSkillScores < ActiveRecord::Migration
  def change
    create_table :skill_scores do |t|
      t.integer :skill_id, null: false
      t.integer :status
      t.boolean :locked
      t.integer :rate
      t.float :rp
      t.integer :grade
      t.integer :combo
      t.boolean :ultimate
      t.integer :score

      t.timestamps
    end
  end
end
