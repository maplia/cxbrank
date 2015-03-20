require 'test_helper'

class SkillScoreTest < ActiveSupport::TestCase
  def setup
    music = Music.where('text_id = ?', 'somedayinst').first
    @music_score = music.score(:difficulty3)
  end

  test "default" do
    score = SkillScore.default(@music_score)
    assert_instance_of SkillScore, score
    assert_equal @music_score.difficulty, score.difficulty
    assert_equal @music_score, score.music_score
    assert_equal @music_score.level, score.music_score.level
    assert !score.locked
    assert !score.ultimate
    assert_nil score.rp
    assert_nil score.rate
    assert_equal GRADE_STATUSES[0][1], score.grade
    assert_equal COMBO_STATUSES[0][1], score.combo
  end

  test "calc!" do
    score = SkillScore.new({music_score: @music_score, ultimate: false, rp: nil, rate: 97})
    score.calc!
    assert_equal 75.36, score.rp  # (77.7 * 0.97 * 1.0).truncate(2)

    score = SkillScore.new({music_score: @music_score, ultimate: true, rp: nil, rate: 97})
    score.calc!
    assert_equal 90.44, score.rp  # (77.7 * 0.97 * 1.2).truncate(2)
  end

  test "ultimate_rate" do
    score = SkillScore.new({music_score: @music_score, ultimate: false, rp: 77.70, rate: 100})
    assert_nil score.ultimate_rate

    score = SkillScore.new({music_score: @music_score, ultimate: true, rp: 90.44, rate: 100})
    assert_equal 97, score.ultimate_rate

    score = SkillScore.new({music_score: @music_score, ultimate: true, rp: 91.37, rate: 100})
    assert_equal 98, score.ultimate_rate

    score = SkillScore.new({music_score: @music_score, ultimate: true, rp: 92.30, rate: 100})
    assert_equal 99, score.ultimate_rate
  end
end
