class CreateBonusMusics < ActiveRecord::Migration
  def change
    create_table :bonus_musics do |t|
      t.integer :music_id
      t.datetime :period_start
      t.datetime :period_end

      t.timestamps
    end
  end
end
