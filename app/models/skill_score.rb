class SkillScore < ActiveRecord::Base
  belongs_to :skill

  def self.default
    return self.new({
      status: PLAY_STATUSES[:noplay][:value],
      locked: false,
      ultimate: false,
      rate: nil,
      rp: nil,
      grade: GRADE_STATUSES[0][1],
      combo: COMBO_STATUSES[0][1],
    })
  end
end
