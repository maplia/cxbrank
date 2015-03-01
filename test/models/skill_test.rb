require 'test_helper'

class SkillTest < ActiveSupport::TestCase
  test "select_by_user_id" do
    skills = Skill.select_by_user_id('00001')
    assert_equal skills.size, Music.all.count
  end
end
