class Music < ActiveRecord::Base
  has_many :music_scores
  has_one :bonus_music, ->(object) {where('period_start <= ? and period_end > ?', object.time, object.time)}
  attr_accessor :time

  scope :current, ->(session) {find(session[:skill][:music_id])}
  scope :find_by_params!, ->(params) {find_by!(text_id: params[:id])}

  def self.all_with_bonus_flag(time=nil)
    includes(:music_scores).order(:number).each do |music|
      music.time = time || Time.now
    end
  end

  def bonus?
    bonus_music
  end

  def difficulty_exist?(difficulty)
    return !level(difficulty).nil?
  end

  def score(difficulty)
    @score_hash = music_scores.index_by(&:difficulty) unless @score_hash
    @score_hash[DIFFICULTIES[difficulty][:id]]
  end

  def level(difficulty)
    return send_to_score(difficulty, :level)
  end

  def notes(difficulty)
    return send_to_score(difficulty, :notes)
  end

  private
  def send_to_score(difficulty, method)
    @score_hash = music_scores.index_by(&:difficulty) unless @score_hash
    @score_hash[DIFFICULTIES[difficulty][:id]].try(:send, method)
  end
end
