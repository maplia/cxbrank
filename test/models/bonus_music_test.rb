require 'test_helper'

class BonusMusicTest < ActiveSupport::TestCase
  test "current" do
    bonus_201312_ids = [
      bonus_musics(:bonus201312_1).music_id,
      bonus_musics(:bonus201312_2).music_id,
      bonus_musics(:bonus201312_3).music_id
    ]
    bonus_201401_ids = [
      bonus_musics(:bonus201401_1).music_id,
      bonus_musics(:bonus201401_2).music_id,
      bonus_musics(:bonus201401_3).music_id
    ]

    result = BonusMusic.current
    assert_equal result.count, bonus_201401_ids.size
    result.each do |r|
      assert_instance_of BonusMusic, r
      assert !bonus_201312_ids.include?(r.music_id)
      assert bonus_201401_ids.include?(r.music_id)
    end
  end

  test "past" do
    bonus_201312_ids = [
      bonus_musics(:bonus201312_1).music_id,
      bonus_musics(:bonus201312_2).music_id,
      bonus_musics(:bonus201312_3).music_id
    ]
    bonus_201401_ids = [
      bonus_musics(:bonus201401_1).music_id,
      bonus_musics(:bonus201401_2).music_id,
      bonus_musics(:bonus201401_3).music_id
    ]

    result = BonusMusic.past(Time.parse('2013-12-15 04:00'))
    assert_equal result.count, bonus_201312_ids.size
    result.each do |r|
      assert_instance_of BonusMusic, r
      assert bonus_201312_ids.include?(r.music_id)
      assert !bonus_201401_ids.include?(r.music_id)
    end

    result = BonusMusic.past
    assert_equal result.count, bonus_201401_ids.size
    result.each do |r|
      assert_instance_of BonusMusic, r
      assert !bonus_201312_ids.include?(r.music_id)
      assert bonus_201401_ids.include?(r.music_id)
    end
  end
end
