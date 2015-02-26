class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.integer :number
      t.string :text_id
      t.string :title
      t.string :sortkey
      t.float :difficulty1_level
      t.float :difficulty2_level
      t.float :difficulty3_level
      t.float :difficulty4_level
      t.float :difficulty5_level
      t.integer :difficulty1_notes
      t.integer :difficulty2_notes
      t.integer :difficulty3_notes
      t.integer :difficulty4_notes
      t.integer :difficulty5_notes
      t.datetime :added_at

      t.timestamps
    end
  end
end
