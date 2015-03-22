class CreateSkillScores < ActiveRecord::Migration
  def change
    create_table :skill_scores do |t|
      t.references :skill, null: false
      t.integer :difficulty, null: false
      t.integer :status
      t.boolean :locked
      t.integer :rate
      t.float :rp
      t.integer :grade
      t.integer :combo
      t.boolean :ultimate
      t.integer :score

      t.timestamps null: false
    end
  end

  add_foreign_key :skill_scores, :skills
end
