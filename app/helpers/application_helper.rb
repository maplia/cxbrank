module ApplicationHelper
  def header_title(page_title=nil)
    if page_title
      return "#{page_title} - #{APP_INFO[:name]}"
    else
      return APP_INFO[:name]
    end
  end

  def h1_title(page_title=nil)
    return page_title || APP_INFO[:name]
  end

  def sprintf_for_level(level)
    return level ? sprintf('%.1f', level) : '-'
  end

  def sprintf_for_notes(notes)
    return notes ? sprintf('%d', notes) : '-'
  end

  def sprintf_for_rp(rp)
    return rp ? sprintf('%.2f', rp) : '-'
  end

  def sprintf_for_rate(rate)
    return rate ? sprintf('%d%%', rate) : '-'
  end

  def difficulty_id_to_sym(id)
    sym = "difficulty#{id}".to_sym
    return DIFFICULTIES.has_key?(sym) ? sym : nil
  end
end
