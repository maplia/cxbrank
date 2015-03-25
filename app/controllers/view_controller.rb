class ViewController < ApplicationController
  skip_before_action :check_logined

  def show
    @user = User.find_by_params!(params)
    @skill_set = SkillSet.all_by_user(@user, registered_only: true)

    @page_title = "#{@user.username}さんのランクポイント表"
  end
end
