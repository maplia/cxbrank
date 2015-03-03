module ApplicationHelper
  def header_title(page_title=nil)
    if page_title
      return "#{page_title} - #{Settings.app_name}"
    else
      return Settings.app_name
    end
  end

  def h1_title(page_title=nil)
    return page_title || Settings.app_name
  end

  def sprintf_for_level(level)
    return sprintf('%.1f', level)
  end

  def sprintf_for_rp(rp)
    return sprintf('%.2f', rp)
  end
end
