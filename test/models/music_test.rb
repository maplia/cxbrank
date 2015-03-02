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

    assert_equal BonusMusic.current.count, bonus_musics.size
    assert_equal Music.all.count - BonusMusic.current.count, regular_musics.size
  end
end
