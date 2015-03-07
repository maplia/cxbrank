class Skill < ActiveRecord::Base
  belongs_to :music

  def self.select_by_user_id(user_id, ignore_locked, time=nil)
    musics = Music.all_with_bonus_flag(time)
    skills = joins(:music).where('user_id = ?', user_id.to_i)
    skill_hash = skills.index_by(&:music_id)

    musics.each do |music|
      if skill_hash.has_key?(music.id)
        skill_hash[music.id].music.bonus = music.bonus
        skill_hash[music.id].calc!(ignore_locked)
      else
        skills << default(user_id, music)
        skill_hash[music.id] = skills.last
      end
    end
    skills.sort!.reverse!

    return skills
  end

  def self.select_by_user_id_and_music(user_id, music)
    skill = joins(:music).where(
      'user_id = ? and text_id = ?', user_id.to_i, music.text_id).first
    unless skill
      skill = default(user_id, Music.where('text_id = ?', music.text_id).first)
    end

    return skill
  end

  def self.default(user_id, music)
    hash = {
      user_id: user_id, music: music, music_id: music.id,
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

    return self.new(hash)
  end

  def calc!(ignore_locked)
  end

  def locked(difficulty)
    return send("#{difficulty}_locked".to_sym)
  end

  def status(difficulty)
    return send("#{difficulty}_status".to_sym)
  end

  def ultimate(difficulty)
    return send("#{difficulty}_ultimate".to_sym)
  end

  def rp(difficulty)
    return send("#{difficulty}_rp".to_sym)
  end

  def rate(difficulty)
    return send("#{difficulty}_rate".to_sym)
  end

  def ultimate_rate(difficulty)
    if ultimate(difficulty)
      return (rp(difficulty) / (music.level(difficulty) * 1.2) * 100).to_i
    else
      return nil
    end
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
