class IglockController < ApplicationController
  skip_before_filter :check_logined

  include SkillData

  def show
    user = User.where('id = ?', params[:id].to_i).first
    raise Cxbrank::UserNotFoundError unless user

    @page_title = "#{user.username}さんのランクポイント表"
    @page_subtitle = "[ロック状態無視]"
    @data = get_skill_data(user, true, true)
  end
end
