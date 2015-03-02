class SkillsController < ApplicationController
  def index
    @page_title = "#{session[:user].username}さんのランクポイント表"
    @blocks = {
      :bonus => {
        :title => '期間限定RP対象曲', :skills => [], :rp => 0.00
      },
      :regular => {
        :title => '一般曲', :skills => [], :rp => 0.00
      },
    }

    Skill.select_by_user_id(session[:user].id).each do |skill|
      if skill.music.bonus
        @blocks[:bonus][:skills] << skill
        @blocks[:bonus][:rp] += skill.best_rp
      else
        @blocks[:regular][:skills] << skill
        @blocks[:regular][:rp] += skill.best_rp
      end
    end
  end
end
