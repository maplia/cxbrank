class CreateBonusMusics < ActiveRecord::Migration
  def change
    create_table :bonus_musics do |t|
      t.integer :music_id, :null => false
      t.datetime :period_start, :null => false
      t.datetime :period_end, :null => false

      t.timestamps
    end
  end
end
