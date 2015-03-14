class SkillsController < ApplicationController
  include SkillData

  def index
    @user = User.where('id = ?', session[:user_id]).first

    @page_title = "#{@user.username}さんのランクポイント表"
    @data = get_skill_data(@user)
  end

  def edit
    @user = User.where('id = ?', session[:user_id]).first
    music = Music.where('text_id = ?', params[:id]).first

    @skill_old = Skill.select_by_user_and_music(@user, music)
    @skill = Marshal.load(Marshal.dump(@skill_old))
    load_skill_params(@skill) if music.id == session[:music_id]

    session[:music_id] = music.id

    @page_title = "ランクポイント編集"
    @page_subtitle = "[#{music.title}]"
  end

  def confirm
    user = User.where('id = ?', session[:user_id]).first
    music = Music.where('id = ?', session[:music_id]).first

    session[:skill] = params.require(:skill).permit([:comment])
    DIFFICULTIES.each_key do |difficulty|
      next unless music.difficulty_exist?(difficulty)
      session[difficulty] = params.require(difficulty).permit([
        :status, :locked, :ultimate, :rp, :rate, :grade, :combo,
      ])
    end

    @skill_old = Skill.select_by_user_and_music(user, music)
    @skill = Skill.select_by_user_and_music(user, music)

    load_skill_params(@skill)
    @skill.calc!

    @page_title = "ランクポイント編集確認"
    @page_subtitle = "[#{music.title}]"

    if params[:delete]
      session[:operation] = :destroy
    else
      if params[:new_record] == true.to_s
        session[:operation] = :create
      else
        session[:operation] = :update
      end
    end
  end

  def update
    user = User.where('id = ?', session[:user_id]).first
    music = Music.where('id = ?', session[:music_id]).first

    if params[:no]
      redirect_to edit_skill_path(music.text_id)
    else
      if session[:operation] == :create
        skill = Skill.default(user, music, true)
      else
        skill = Skill.where('user_id = ? and music_id = ?', session[:user_id], session[:music_id]).first
      end
      load_skill_params(skill)

      begin
        Skill.transaction do
          skill.save!
          skill.skill_scores.each do |score|
            score.save!
          end

          reset_skill_session
          redirect_to :skills
        end
      rescue
        redirect_to edit_skill_path(music.text_id)
      end
    end
  end

  def destroy
    music = Music.where('id = ?', session[:music_id]).first

    if params[:no]
      redirect_to edit_skill_path(music.text_id)
    else
      skill = Skill.where('user_id = ? and music_id = ?', session[:user_id], session[:music_id]).first

      begin
        Skill.transaction do
          skill.skill_scores.each do |score|
            score.destroy!
          end
          skill.destroy!

          reset_skill_session
          redirect_to :skills
        end
      rescue
        redirect_to edit_skill_path(music.text_id)
      end
    end
  end

  private
  def load_skill_params(skill)
    if session[:skill]
      skill.attributes = session[:skill]
      skill.skill_scores.each do |score|
        difficulty = "difficulty#{score.difficulty}".to_sym
        score.attributes = session[difficulty]
      end
      skill.calc!
    end
  end

  def reset_skill_session
    session[:music_id] = nil
    session[:skill] = nil
    DIFFICULTIES.each_key do |difficulty|
      session[difficulty] = nil
    end
    session[:operation] = nil
  end
end
