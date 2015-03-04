require 'test_helper'

class BonusMusicTest < ActiveSupport::TestCase
  def setup
    @bonus_201312_ids = [
      bonus_musics(:bonus201312_1).music_id,
      bonus_musics(:bonus201312_2).music_id,
      bonus_musics(:bonus201312_3).music_id,
    ]
    @bonus_201401_ids = [
      bonus_musics(:bonus201401_1).music_id,
      bonus_musics(:bonus201401_2).music_id,
      bonus_musics(:bonus201401_3).music_id,
      bonus_musics(:bonus201401_4).music_id,
    ]
  end

  test "current" do
    musics = BonusMusic.current
    assert_equal musics.count, @bonus_201401_ids.size
    musics.each do |music|
      assert_instance_of BonusMusic, music
      assert !@bonus_201312_ids.include?(music.music_id)
      assert @bonus_201401_ids.include?(music.music_id)
    end
  end

  test "past" do
    musics = BonusMusic.past(Time.parse('2013-12-15 04:00'))
    assert_equal musics.count, @bonus_201312_ids.size
    musics.each do |music|
      assert_instance_of BonusMusic, music
      assert @bonus_201312_ids.include?(music.music_id)
      assert !@bonus_201401_ids.include?(music.music_id)
    end

    musics = BonusMusic.past
    assert_equal musics.count, @bonus_201401_ids.size
    musics.each do |music|
      assert_instance_of BonusMusic, music
      assert !@bonus_201312_ids.include?(music.music_id)
      assert @bonus_201401_ids.include?(music.music_id)
    end
  end
end
