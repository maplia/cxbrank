class Skill < ActiveRecord::Base
  belongs_to :user
  belongs_to :music

  def self.select_by_user_id(user_id, datetime=nil)
    musics = Music.all_with_bonus_flag(datetime)
    skills = Skill.joins(:music).where('user_id = ?', user_id.to_i)
    
    musics.each do |music|
      registered = false
      skills.each do |skill|
        if skill.music.id == music.id
          registered = true
          break
        end
      end
      next if registered

      skills << Skill.empty_skill(music)
    end

    return skills
  end

  def self.empty_skill(music)
    return self.new({
      :music => music,
      :music_id => music.id
    })
  end

  def <=>(other)
    return self.best_rp <=> other.best_rp
  end
end
