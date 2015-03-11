class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.integer :number, null: false
      t.string :text_id, null: false
      t.string :title, null: false
      t.string :subtitle
      t.string :sortkey, null: false
      t.datetime :added_at, null: false

      t.timestamps
    end
  end
end
