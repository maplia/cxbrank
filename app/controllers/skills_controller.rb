class SkillsController < ApplicationController
  def index
    @page_title = "#{session[:user].username}さんのランクポイント表"
    @blocks = {
      :bonus => {
        id: LIST_BLOCKS[:bonus][:id], title: LIST_BLOCKS[:bonus][:title], skills: [], sum_rp: 0.00,
      },
      :regular => {
        id: LIST_BLOCKS[:regular][:id], title: LIST_BLOCKS[:regular][:title], skills: [], sum_rp: 0.00,
      },
    }

    Skill.select_by_user_id(session[:user].id).each do |skill|
      if skill.music.bonus
        @blocks[:bonus][:skills] << skill
        @blocks[:bonus][:sum_rp] += skill.best_rp
      else
        @blocks[:regular][:skills] << skill
        @blocks[:regular][:sum_rp] += skill.best_rp
      end
    end
  end
end
