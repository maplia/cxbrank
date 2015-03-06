class Skill < ActiveRecord::Base
  belongs_to :music
  attr_accessor :difficulty_skills

  def self.select_by_user_id(user_id, time=nil)
    musics = Music.all_with_bonus_flag(time)
    skills = Skill.joins(:music).where('user_id = ?', user_id.to_i).order(:best_rp)
    skill_hash = skills.index_by(&:music_id)

    musics.each do |music|
      if skill_hash.has_key?(music.id)
        skill_hash[music.id].music.bonus = music.bonus
      else
        skills << Skill.default(user_id, music)
        skill_hash[music.id] = skills.last
      end

      skill_hash[music.id].calc!
    end

    return skills
  end

  def self.default(user_id, music)
    return self.new({
      user_id: user_id, music: music, music_id: music.id,
      best_rp: 0.00
    })
  end

  def calc!
    @difficulty_skills = {}

    DIFFICULTIES.each_key do |difficulty|
      @difficulty_skills[difficulty] = {
        locked: send("#{difficulty}_locked".to_sym),
        status: send("#{difficulty}_status".to_sym),
        rate: send("#{difficulty}_rate".to_sym),
        rp: send("#{difficulty}_rp".to_sym),
        grade: send("#{difficulty}_grade".to_sym),
        combo: send("#{difficulty}_combo".to_sym),
        ultimate: send("#{difficulty}_ultimate".to_sym),
      }
    end
  end

  def <=>(other)
    return self.best_rp <=> other.best_rp
  end
end
