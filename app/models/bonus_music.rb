class BonusMusic < ActiveRecord::Base
  belongs_to :music

  def self.current
    return self.past
  end

  def self.past(time=nil)
    time = Time.now unless time
    return self.where('period_start <= ? and period_end > ?', time, time)
  end
end
