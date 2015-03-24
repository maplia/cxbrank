require 'test_helper'

class SkillTest < ActiveSupport::TestCase
  def setup
    @user = User.find(users(:testuser1).id)
    @music = Music.find_by_text_id('somedayinst')
  end

  test "default" do
    skill = Skill.default(@user, @music)
    assert_instance_of Skill, skill
    assert_equal @music, skill.music
    assert_nil skill.best_difficulty
    assert_equal 0.00, skill.best_rp
    assert_equal @music.music_scores.size, skill.skill_scores.size
    skill.skill_scores.each do |score|
      music_score = @music.score("difficulty#{score.difficulty}".to_sym)
      assert_instance_of SkillScore, score
      assert_instance_of MusicScore, score.music_score
      assert_equal music_score, score.music_score
      assert !score.locked
      assert !score.ultimate
      assert_nil score.rp
      assert_nil score.rate
      assert_equal GRADE_STATUSES[0][1], score.grade
      assert_equal COMBO_STATUSES[0][1], score.combo
    end
  end

  test "score" do
    skill = Skill.default(@user, @music)

    assert_equal @music.score(:difficulty1), skill.score(:difficulty1).music_score
    assert_equal @music.score(:difficulty2), skill.score(:difficulty2).music_score
    assert_equal @music.score(:difficulty3), skill.score(:difficulty3).music_score
  end

  test "calc!" do
    skill = Skill.default(@user, @music)
    skill.calc!
    assert_equal 0, skill.best_difficulty
    assert_equal 0.00, skill.best_rp

    skill = Skill.default(@user, @music)
    skill.score(:difficulty2).attributes = {
      status: PLAY_STATUSES[:cleared][:value], rate: 100, locked: false, ultimate: false
    }
    skill.score(:difficulty3).attributes = {
      status: PLAY_STATUSES[:cleared][:value], rate: 100, locked: false, ultimate: false
    }
    skill.calc!
    assert_equal 3, skill.best_difficulty
    assert_equal @music.score(:difficulty3).level * 1.00, skill.best_rp

    skill = Skill.default(@user, @music)
    skill.score(:difficulty2).attributes = {
      status: PLAY_STATUSES[:cleared][:value], rate: 100, locked: false, ultimate: false
    }
    skill.score(:difficulty3).attributes = {
      status: PLAY_STATUSES[:cleared][:value], rate: 100, locked: true, ultimate: false
    }
    skill.calc!
    assert_equal 2, skill.best_difficulty
    assert_equal @music.score(:difficulty2).level * 1.00, skill.best_rp
    skill.calc!(ignore_locked: true)
    assert_equal 3, skill.best_difficulty
    assert_equal @music.score(:difficulty3).level * 1.00, skill.best_rp
  end
end
