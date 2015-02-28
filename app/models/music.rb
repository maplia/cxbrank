class Music < ActiveRecord::Base
  def self.bonus_musics
    bonus_musics = BonusMusic.current
    return self.where("id in (#{bonus_musics.to_sql})").order('number')
  end

  def self.regular_musics
    bonus_musics = BonusMusic.current
    return self.where("id not in (#{bonus_musics.to_sql})").order('number')
  end
end
