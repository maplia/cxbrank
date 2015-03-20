class SkillScore < ActiveRecord::Base
  belongs_to :skill
  has_one :music_score
  attr_accessor :music_score

  def self.default(music_score)
    score = self.new({
      music_score: music_score,
      difficulty: music_score.difficulty,
      status: PLAY_STATUSES[:noplay][:value],
      locked: false,
      ultimate: false,
      rate: nil,
      rp: nil,
      grade: GRADE_STATUSES[0][1],
      combo: COMBO_STATUSES[0][1],
    })
  end

  def calc!
    unless rp
      temp_rp = (music_score.level * (rate || 0)) / 100.0
      temp_rp *= 1.2 if ultimate?
      self.rp = BigDecimal.new(temp_rp.to_s).truncate(2)
    end
  end
  
  def cleared?
    status == PLAY_STATUSES[:cleared][:value]
  end

  def ultimate_rate
    ultimate? ? (rp / (music_score.level * 1.2) * 100).ceil.to_i : nil
  end
end
