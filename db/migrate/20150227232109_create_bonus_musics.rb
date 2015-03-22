class CreateBonusMusics < ActiveRecord::Migration
  def change
    create_table :bonus_musics do |t|
      t.references :music, null: false
      t.datetime :period_start, null: false
      t.datetime :period_end, null: false

      t.timestamps null: false
    end
  end

  add_foreign_key :bonus_musics, :musics
end
