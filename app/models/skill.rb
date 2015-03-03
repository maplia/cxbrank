class Skill < ActiveRecord::Base
  belongs_to :music

  def self.select_by_user_id(user_id, time=nil)
    musics = Music.all_with_bonus_flag(time)
    skills = Skill.joins(:music).where('user_id = ?', user_id.to_i).order(:best_rp)

    skill_hash = {}
    skills.each do |skill|
      skill_hash[skill.music_id] = skill
    end

    musics.each do |music|
      if skill_hash.has_key?(music.id)
        skill_hash[music.id].music.bonus = music.bonus
      else
        skills << Skill.default(user_id, music)
      end
    end

    return skills
  end

  def self.default(user_id, music)
    return self.new({
      user_id: user_id, music: music, music_id: music.id,
      best_rp: 0.00
    })
  end

  def status(difficulty)
    return self["#{difficulty}_status".to_sym]
  end

  def notes(difficulty)
    return self["#{difficulty}_notes".to_sym]
  end

  def <=>(other)
    return self.best_rp <=> other.best_rp
  end
end
