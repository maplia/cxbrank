class SkillsController < ApplicationController
  include SkillData

  def index
    user = User.where('id = ?', session[:user_id]).first
    @page_title = "#{user.username}さんのランクポイント表"
    @data = get_skill_data(user, false)
  end

  def edit
    user = User.where('id = ?', session[:user_id]).first
    music = Music.where('text_id = ?', params[:id]).first
    session[:music_id] = music.id

    @page_title = "ランクポイント編集"
    @page_subtitle = "[#{music.title}]"
    @skill = Skill.select_by_user_and_music(user, music)
    @skill.attributes = session[:skill_params] if session[:skill_params]
  end

  def confirm
    permit_params = [:comment]
    DIFFICULTIES.each_key do |difficulty|
      permit_params << "#{difficulty}_status".to_sym
      permit_params << "#{difficulty}_locked".to_sym
      permit_params << "#{difficulty}_ultimate".to_sym
      permit_params << "#{difficulty}_rp".to_sym
      permit_params << "#{difficulty}_rate".to_sym
      permit_params << "#{difficulty}_grade".to_sym
      permit_params << "#{difficulty}_combo".to_sym
    end
    session[:skill_params] = params.require(:skill).permit(permit_params)

    user = User.where('id = ?', session[:user_id]).first
    music = Music.where('id = ?', session[:music_id]).first
    @skill_old = Skill.select_by_user_and_music(user, music)
    @skill = Skill.select_by_user_and_music(user, music)
    @skill.attributes = session[:skill_params] 
    @skill.user_id = user.id
    @skill.music_id = music.id
    @skill.calc!

    @page_title = "ランクポイント編集確認"
    @page_subtitle = "[#{music.title}]"

    if params[:delete]
      session[:action] = :destroy
    else
      if params[:new_record] == 'true'
        session[:action] = :create
      else
        session[:action] = :update
      end
    end
  end
  
  def create
    if params[:no]
      redirect_to :back
    else
      skill = Skill.new
      skill.user_id = session[:user_id]
      skill.music_id = session[:music_id]
      skill.attributes = session[:skill_params]
      if skill.save
        session[:music_id] = nil
        session[:skill_params] = nil
        session[:operation] = nil
        redirect_to :skills
      else
        redirect_to :back
      end
    end
  end

  def update
    if params[:no]
      redirect_to :back
    else
      skill = Skill.where('user_id = ? and music_id = ?', session[:user_id], session[:music_id]).first
      skill.attributes = session[:skill_params]
      skill.save
      session[:music_id] = nil
      session[:skill_params] = nil
      session[:operation] = nil
      redirect_to :skills
    end
  end

  def destroy
    if params[:no]
      redirect_to :back
    else
      skill = Skill.where('user_id = ? and music_id = ?', session[:user_id], session[:music_id]).first
      skill.destroy
      session[:music_id] = nil
      session[:skill_params] = nil
      session[:operation] = nil
      redirect_to :skills
    end
  end
end
