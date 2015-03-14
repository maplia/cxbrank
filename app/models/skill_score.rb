class SkillScore < ActiveRecord::Base
  belongs_to :skill
  attr_accessor :music_score

  def self.default(difficulty, music_score)
    score = self.new({
      difficulty: DIFFICULTIES[difficulty][:id],
      status: PLAY_STATUSES[:noplay][:value],
      locked: false,
      ultimate: false,
      rate: nil,
      rp: nil,
      grade: GRADE_STATUSES[0][1],
      combo: COMBO_STATUSES[0][1],
    })
    score.music_score = music_score
    
    return score
  end

  def validate
  end
end
