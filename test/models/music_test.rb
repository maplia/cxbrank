require 'test_helper'

class MusicTest < ActiveSupport::TestCase
  def setup
    @music = Music.where('number = ?', musics(:wannabeyourspecial).number).first
  end
  
  test "all_with_bonus_flag" do
    musics = Music.all_with_bonus_flag
    bonus_musics = []
    regular_musics = []

    musics.each do |r|
      if r.bonus
        bonus_musics << r
      else
        regular_musics << r
      end
    end

    assert_equal BonusMusic.current.count, bonus_musics.size
    assert_equal Music.all.count - BonusMusic.current.count, regular_musics.size
  end

  test "level" do
    assert_equal musics(:wannabeyourspecial).difficulty1_level, @music.level(:difficulty1)
    assert_equal musics(:wannabeyourspecial).difficulty2_level, @music.level(:difficulty2)
    assert_equal musics(:wannabeyourspecial).difficulty3_level, @music.level(:difficulty3)
  end

  test "notes" do
    assert_equal musics(:wannabeyourspecial).difficulty1_notes, @music.notes(:difficulty1)
    assert_equal musics(:wannabeyourspecial).difficulty2_notes, @music.notes(:difficulty2)
    assert_equal musics(:wannabeyourspecial).difficulty3_notes, @music.notes(:difficulty3)
  end
end
