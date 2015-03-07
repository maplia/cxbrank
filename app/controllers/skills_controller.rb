class SkillsController < ApplicationController
  def index
    @edit = true
    @page_title = "#{session[:user].username}さんのランクポイント表"
    @blocks = {}
    LIST_BLOCKS.each do |key, value|
      @blocks[key] = {
        id: value[:id], title: value[:title], target_count: value[:target_count],
        skills: [], sum_rp: 0.00,
      }
    end

    Skill.select_by_user_id(session[:user].id, false).each do |skill|
      if skill.music.bonus
        @blocks[:bonus][:skills] << skill
        @blocks[:bonus][:sum_rp] += skill.best_rp
      else
        @blocks[:regular][:skills] << skill
        if @blocks[:regular][:skills].size <= @blocks[:regular][:target_count]
          @blocks[:regular][:sum_rp] += skill.best_rp
        end
      end
    end
  end

  def edit
    music = Music.where('text_id = ?', params[:text_id]).first
    @page_title = "ランクポイント編集 [#{music.title}]"
    @skill = Skill.select_by_user_id_and_music(session[:user].id, music)
  end
end
