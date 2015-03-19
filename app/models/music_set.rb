class MusicSet
  include BonusUtil

  def initialize(musics)
    @blocks = devide_blocks(musics)
  end
  
  def self.all(time=nil)
    MusicSet.new(Music.all_with_bonus_flag(time))
  end
end
