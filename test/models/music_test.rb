require 'test_helper'

class MusicTest < ActiveSupport::TestCase
  test "all_with_bonus_flag" do
    result = Music.all_with_bonus_flag
    bonus_musics = []
    regular_musics = []

    result.each do |r|
      if r.bonus
        bonus_musics << r
      else
        regular_musics << r
      end
    end

    assert_equal bonus_musics.size, BonusMusic.current.count
    assert_equal regular_musics.size, Music.all.count - BonusMusic.current.count
  end

  test "bonus_musics" do
    result = Music.bonus_musics
    assert_equal result.count, BonusMusic.current.count

    time = Time.parse('2013-12-15 4:00')
    result = Music.bonus_musics(time)
    assert_equal result.count, BonusMusic.past(time).count
  end

  test "regular_musics" do
    result = Music.regular_musics
    assert_equal result.count, Music.all.count - BonusMusic.current.count

    time = Time.parse('2013-12-15 4:00')
    result = Music.regular_musics(time)
    assert_equal result.count, Music.all.count - BonusMusic.past(time).count
  end
end
