class Skill < ActiveRecord::Base
  belongs_to :music

  DIFFICULTIES.each_key do |difficulty|
    validate "#{difficulty}_rate".to_sym,
      numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
  end

  def self.select_by_user(user, ignore_locked=false, time=nil)
    musics = Music.all_with_bonus_flag(time)
    skills = self.where('user_id = ?', user.id)
    skill_hash = skills.index_by(&:music_id)

    musics.each do |music|
      if skill_hash.has_key?(music.id)
        skill_hash[music.id].music.bonus = music.bonus
        skill_hash[music.id].calc!(ignore_locked)
      else
        skills << default(user, music)
        skill_hash[music.id] = skills.last
      end
    end
    skills.sort!.reverse!

    return skills
  end

  def self.select_by_user_and_music(user, music)
    skill = joins(:music).where('user_id = ? and music_id = ?', user.id, music.id).first
    skill = default(user, music) unless skill

    return skill
  end

  def self.default(user, music)
    hash = {
      user_id: user.id, music_id: music.id,
      best_difficulty: nil, best_rp: 0.00,
    }
    DIFFICULTIES.each_key do |difficulty|
      hash["#{difficulty}_status".to_sym] = 0
      hash["#{difficulty}_locked".to_sym] = false
      hash["#{difficulty}_ultimate".to_sym] = false
      hash["#{difficulty}_rp".to_sym] = 0.00
      hash["#{difficulty}_rate".to_sym] = 0
      hash["#{difficulty}_grade".to_sym] = 0
      hash["#{difficulty}_combo".to_sym] = 0
    end

    skill = self.new(hash)
    skill.music = music

    return skill
  end

  def calc!(ignore_locked=false)
    self.music = Music.where('id = ?', self[:music_id]).first unless self.music
    self.best_rp = 0.00

    DIFFICULTIES.keys.each_with_index do |difficulty, i|
      if !rp(difficulty) or rp(difficulty) == 0
        temp = self.music.level(difficulty) * (rate(difficulty) || 0) / 100.0
        if ultimate(difficulty)
          temp *= 1.2
        end
        self["#{difficulty}_rp".to_sym] = (temp * 100).to_i / 100.0
      end

      if !ignore_locked or !locked(difficulty)
        if self.best_rp < rp(difficulty)
          self.best_difficulty = i+1
          self.best_rp = rp(difficulty)
        end
      end
    end
  end

  def locked(difficulty)
    return self["#{difficulty}_locked".to_sym]
  end

  def status(difficulty)
    return self["#{difficulty}_status".to_sym]
  end

  def ultimate(difficulty)
    return self["#{difficulty}_ultimate".to_sym]
  end

  def rp(difficulty)
    return self["#{difficulty}_rp".to_sym]
  end

  def rate(difficulty)
    return self["#{difficulty}_rate".to_sym]
  end

  def ultimate_rate(difficulty)
    if ultimate(difficulty)
      return (rp(difficulty) / (music.level(difficulty) * 1.2) * 100).to_i
    else
      return nil
    end
  end

  def grade(difficulty)
    return self["#{difficulty}_grade".to_sym]
  end

  def combo(difficulty)
    return self["#{difficulty}_combo".to_sym]
  end

  def <=>(other)
    return self.best_rp <=> other.best_rp
  end
end
