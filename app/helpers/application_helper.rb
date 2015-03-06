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
    if level
      return sprintf('%.1f', level)
    else
      return '-'
    end
  end

  def sprintf_for_notes(notes)
    if notes
      return sprintf('%d', notes)
    else
      return '-'
    end
  end

  def sprintf_for_rp(rp)
    return sprintf('%.2f', rp)
  end

  def difficulty_id_to_sym(id)
    sym = "difficulty#{id}".to_sym
    return DIFFICULTIES.has_key?(sym) ? sym : nil
  end

  def grade_status_to_sym(status)
    sym = "grade#{status}".to_sym
    return GRADE_STATUSES.has_key?(sym) ? sym : nil
  end

  def combo_status_to_sym(status)
    sym = "combo#{status}".to_sym
    return COMBO_STATUSES.has_key?(sym) ? sym : nil
  end
end
