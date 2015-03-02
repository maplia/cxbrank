class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.integer :number, :null => false
      t.string :text_id, :null => false
      t.string :title, :null => false
      t.string :subtitle
      t.string :sortkey, :null => false
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
      t.datetime :added_at, :null => false

      t.timestamps
    end
  end
end
