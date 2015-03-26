class Skill < ActiveRecord::Base
  belongs_to :user
  belongs_to :music
  has_many :skill_scores
  attr_accessor :target

  def self.select_by_user(user, options={})
    skills = includes(:music).includes(:skill_scores).where('user_id = ?', user.id).to_a

    skills.each do |skill|
      skill.music.time = options[:time]
      skill.skill_scores.each do |score|
        score.music_score = skill.music.score("difficulty#{score.difficulty}".to_sym)
      end
      skill.calc!(ignore_locked: true) if options[:ignore_locked]
    end
    unless options[:registered_only]
      musics = Music.all_with_bonus_flag(options[:time])
      skill_hash = skills.index_by(&:music_id)

      musics.each do |music|
        unless skill_hash.has_key?(music.id)
          skills << default(user, music)
          skill_hash[music.id] = skills.last
        end
      end
    end
    skills.sort!

    return skills
  end

  def self.select_by_user_and_music(user, music)
    if exists?(user_id: user.id, music_id: music.id)
      skill = find_by(user_id: user.id, music_id: music.id)
      skill.skill_scores.each do |score|
        score.music_score = music.score("difficulty#{score.difficulty}".to_sym)
      end
    else
      skill = default(user, music)
    end
    skill
  end

  def self.default(user, music)
    skill_scores = []
    DIFFICULTIES.each_key do |difficulty|
      next unless music.difficulty_exist?(difficulty)
      skill_scores << SkillScore.default(music.score(difficulty))
    end

    self.new({
      music: music,
      best_difficulty: nil, best_rp: 0.00, skill_scores: skill_scores,
    })
  end

  def bonus?
    music.bonus?
  end

  def score(difficulty)
    @score_hash = skill_scores.index_by(&:difficulty) unless @score_hash
    @score_hash[DIFFICULTIES[difficulty][:id]]
  end

  def calc!(options={})
    self.best_difficulty = 0
    self.best_rp = 0.00
    
    DIFFICULTIES.each_key do |difficulty|
      next unless music.difficulty_exist?(difficulty)
      next unless cleared?(difficulty)

      send_to_score(difficulty, :calc!)
      if options[:ignore_locked] or !locked(difficulty)
        if best_rp < rp(difficulty)
          self.best_difficulty = DIFFICULTIES[difficulty][:id]
          self.best_rp = rp(difficulty)
        end
      end
    end
  end

  def status(difficulty)
    return send_to_score(difficulty, :status)
  end

  def cleared?(difficulty)
    return send_to_score(difficulty, :cleared?)
  end

  def locked(difficulty)
    return send_to_score(difficulty, :locked)
  end

  def ultimate(difficulty)
    return send_to_score(difficulty, :ultimate)
  end

  def rp(difficulty)
    return send_to_score(difficulty, :rp)
  end

  def rate(difficulty)
    return send_to_score(difficulty, :rate)
  end

  def grade(difficulty)
    return send_to_score(difficulty, :grade)
  end

  def combo(difficulty)
    return send_to_score(difficulty, :combo)
  end

  def ultimate_rate(difficulty)
    return send_to_score(difficulty, :ultimate_rate)
  end

  def <=>(other)
    if self.best_rp != other.best_rp
      return other.best_rp <=> self.best_rp
    else
      return self.music.sortkey <=> other.music.sortkey
    end
  end

  private
  def send_to_score(difficulty, method)
    @score_hash = skill_scores.index_by(&:difficulty) unless @score_hash
    @score_hash[DIFFICULTIES[difficulty][:id]].try(:send, method)
  end
end
