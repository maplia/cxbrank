class BonusMusic < ActiveRecord::Base
  belongs_to :music

  def self.current
    return self.past
  end

  def self.past(datetime=nil)
    datetime = Time.now unless datetime
    return self.where('period_start <= ? and period_end > ?', datetime, datetime).select('music_id')
  end
end
