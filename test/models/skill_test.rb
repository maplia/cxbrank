require 'test_helper'

class SkillTest < ActiveSupport::TestCase
  test "select_by_user_id" do
    result = Skill.select_by_user_id('00001', false)
    bonus_skills = []
    regular_skills = []

    result.each do |r|
      if r.music.bonus
        bonus_skills << r
      else
        regular_skills << r
      end
    end

    assert_equal BonusMusic.current.count, bonus_skills.size
    assert_equal Music.all.count - BonusMusic.current.count, regular_skills.size
  end
end
