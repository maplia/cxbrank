class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.references :user, null: false
      t.references :music, null: false
      t.string :comment
      t.integer :best_difficulty, default: 0
      t.float :best_rp, default: 0.00

      t.timestamps null: false
    end
  end

  add_foreign_key :skills, :users
  add_foreign_key :skills, :musics
end
