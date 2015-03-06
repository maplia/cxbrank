class Skill < ActiveRecord::Base
  belongs_to :music

  def self.select_by_user_id(user_id, ignore_locked, time=nil)
    musics = Music.all_with_bonus_flag(time)
    skills = self.joins(:music).where('user_id = ?', user_id.to_i)
    skill_hash = skills.index_by(&:music_id)

    musics.each do |music|
      if skill_hash.has_key?(music.id)
        skill_hash[music.id].music.bonus = music.bonus
        skill_hash[music.id].calc!(ignore_locked)
      else
        skills << Skill.default(user_id, music)
        skill_hash[music.id] = skills.last
      end
    end
    skills.sort!

    return skills
  end

  def self.default(user_id, music)
    return self.new({
      user_id: user_id, music: music, music_id: music.id,
      best_rp: 0.00
    })
  end

  def calc!(ignore_locked)
  end

  def locked(difficulty)
    return send("#{difficulty}_locked".to_sym)
  end

  def status(difficulty)
    return send("#{difficulty}_status".to_sym)
  end

  def rp(difficulty)
    return send("#{difficulty}_rp".to_sym)
  end

  def rate(difficulty)
    return send("#{difficulty}_rate".to_sym)
  end

  def ultimate_rate(difficulty)
    return send("#{difficulty}_ultimate_rate".to_sym)
  end

  def grade(difficulty)
    return send("#{difficulty}_grade".to_sym)
  end

  def combo(difficulty)
    return send("#{difficulty}_combo".to_sym)
  end

  def <=>(other)
    return self.best_rp <=> other.best_rp
  end
end
