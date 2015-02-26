module ApplicationHelper
  def header_title(page_title=nil)
    if page_title
      return "#{page_title} - CxB RankPoint Simulator"
    else
      return 'CxB RankPoint Simulator'
    end
  end

  def sprintf_for_level(level)
    return sprintf('%.1f', level)
  end
end
