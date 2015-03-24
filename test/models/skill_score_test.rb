require 'test_helper'

class SkillScoreTest < ActiveSupport::TestCase
  def setup
    music = Music.find_by_text_id('somedayinst')
    @music_score = music.score(:difficulty3)
  end

  test "default" do
    score = SkillScore.default(@music_score)
    assert_instance_of SkillScore, score
    assert_instance_of MusicScore, score.music_score
    assert_equal @music_score, score.music_score
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
    assert_equal BigDecimal.new((77.7 * 0.97 * 1.0).to_s).truncate(2), score.rp

    score = SkillScore.new({music_score: @music_score, ultimate: true, rp: nil, rate: 97})
    score.calc!
    assert_equal BigDecimal.new((77.7 * 0.97 * 1.2).to_s).truncate(2), score.rp
  end

  test "cleared?" do
    score = SkillScore.new({status: PLAY_STATUSES[:cleared][:value]})
    assert score.cleared?

    score = SkillScore.new({status: PLAY_STATUSES[:failed][:value]})
    assert !score.cleared?

    score = SkillScore.new({status: PLAY_STATUSES[:noplay][:value]})
    assert !score.cleared?
  end

  test "fullcombo?" do
    score = SkillScore.new({combo: COMBO_STATUSES[0][1]})
    assert !score.fullcombo?

    score = SkillScore.new({combo: COMBO_STATUSES[1][1]})
    assert score.fullcombo?

    score = SkillScore.new({combo: COMBO_STATUSES[2][1]})
    assert score.fullcombo?
  end

  test "excellent?" do
    score = SkillScore.new({combo: COMBO_STATUSES[0][1]})
    assert !score.excellent?

    score = SkillScore.new({combo: COMBO_STATUSES[1][1]})
    assert !score.excellent?

    score = SkillScore.new({combo: COMBO_STATUSES[2][1]})
    assert score.excellent?
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
