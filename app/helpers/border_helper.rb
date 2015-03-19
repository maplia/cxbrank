module BorderHelper

  def border_clear_rate(notes, rate)
    border_line = (BigDecimal.new((notes * (100 - rate)).to_s) / BigDecimal.new('40'))
    return border_line.floor
  end

  def border_grade(notes, percent)
    border_line = (BigDecimal.new((notes * (100 - percent)).to_s) / BigDecimal.new('100'))
    return border_line.floor
  end

end
