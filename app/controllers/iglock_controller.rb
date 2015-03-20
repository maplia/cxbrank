class IglockController < ApplicationController
  skip_before_action :check_logined

  def show
    @user = User.find(params[:id].to_i)
    raise Cxbrank::UserNotFoundError unless @user
    @skill_set = SkillSet.all_by_user(@user, registered_only: true, ignore_locked: true)

    @page_title = "#{@user.username}さんのランクポイント表"
    @page_subtitle = "[ロック状態無視]"
  end
end
