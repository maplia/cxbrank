class Skill < ActiveRecord::Base
  belongs_to :user
  belongs_to :music
  has_many :skill_scores
  attr_accessor :difficulty1, :difficulty2, :difficulty3, :difficulty4, :difficulty5

  DIFFICULTIES.each_key do |difficulty|
    validate "#{difficulty}_rate".to_sym,
      numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
  end

  def self.select_by_user(user, ignore_locked=false, time=nil)
    musics = Music.all_with_bonus_flag(time)
    skills = includes(:skill_scores).where('user_id = ?', user.id).to_a
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
    skills.sort!

    return skills
  end

  def self.select_by_user_and_music(user, music)
    skill = includes(:music).where('user_id = ? and music_id = ?', user.id, music.id).first
    skill = default(user, music) unless skill

    return skill
  end

  def self.default(user, music)
    hash = {
      user_id: user.id, music_id: music.id,
      best_difficulty: 0, best_rp: 0.00,
    }

    skill = self.new(hash)
    skill.music = music
    DIFFICULTIES.each_key do |difficulty|
      skill.send("#{difficulty}=", SkillScore.default)
    end

    return skill
  end

  def calc!(ignore_locked=false)
    self.best_rp = 0.00
    DIFFICULTIES.each do |difficulty, data|
      self["#{difficulty}_rp"] = 0.00 unless rp(difficulty)
      self["#{difficulty}_rate"] = 0 unless rate(difficulty)

      if rp(difficulty) == 0.00
        temp = self.music.level(difficulty) * (rate(difficulty) || 0) / 100.0
        if ultimate(difficulty)
          temp *= 1.2
        end
        self["#{difficulty}_rp".to_sym] = (temp * 100).to_i / 100.0
      end

      if ignore_locked or !locked(difficulty)
        if self.best_rp < rp(difficulty)
          self.best_difficulty = data[:id]
          self.best_rp = rp(difficulty)
        end
      end
    end
  end

  def locked(difficulty)
    return send(difficulty).locked
  end

  def status(difficulty)
    return send(difficulty).status
  end

  def ultimate(difficulty)
    return send(difficulty).ultimate
  end

  def rp(difficulty)
    return send(difficulty).rp
  end

  def rate(difficulty)
    return send(difficulty).rate
  end

  def ultimate_rate(difficulty)
    if ultimate(difficulty)
      return (rp(difficulty) / (music.level(difficulty) * 1.2) * 100).to_i
    else
      return nil
    end
  end

  def grade(difficulty)
    return send(difficulty).grade
  end

  def combo(difficulty)
    return send(difficulty).combo
  end

  def <=>(other)
    if self.best_rp != other.best_rp
      return other.best_rp <=> self.best_rp
    else
      return self.music.sortkey <=> other.music.sortkey
    end
  end
end
