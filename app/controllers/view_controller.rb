class ViewController < ApplicationController
  include SkillData

  def show
    user = User.where('id = ?', params[:id].to_i).first
    @page_title = "#{user.username}さんのランクポイント表"
    @data = get_skill_data(user, true)
  end
end
