class SkillsController < ApplicationController
  def index
    @user = User.current(session)
    @skill_set = SkillSet.all_by_user(@user)

    @page_title = "#{@user.username}さんのランクポイント表"
  end

  def edit
    @user = User.current(session)
    music = Music.find_by_params(params)

    @skill_old = Skill.select_by_user_and_music(@user, music)
    @skill = Marshal.load(Marshal.dump(@skill_old))
    load_skill_params(@skill) if session[:skill]

    session[:skill] = {}
    session[:skill][:music_id] = music.id

    @page_title = "ランクポイント編集"
    @page_subtitle = "[#{[music.title, music.subtitle].join(" ")}]"
  end

  def confirm
    user = User.current(session)
    music = Music.current(session)

    session[:skill][:params] = params.require(:skill).permit([:comment])
    session[:skill][:new_record] = params.require(:skill).permit([:new_record])
    DIFFICULTIES.each_key do |difficulty|
      next unless music.difficulty_exist?(difficulty)
      session[:skill][difficulty] = params.require(difficulty).permit([
        :status, :locked, :ultimate, :rp, :rate, :grade, :combo,
      ])
    end

    @skill_old = Skill.select_by_user_and_music(user, music)
    @skill = Skill.select_by_user_and_music(user, music)

    load_skill_params(@skill)
    @skill.calc!

    @page_title = "ランクポイント編集確認"
    @page_subtitle = "[#{[music.title, music.subtitle].join(" ")}]"

    if params[:delete]
      session[:skill][:operation] = :destroy
    else
      if session[:skill][:new_record] == true.to_s
        session[:skill][:operation] = :create
      else
        session[:skill][:operation] = :update
      end
    end
  end

  def update
    user = User.current(session)
    music = Music.current(session)

    if params[:no]
      redirect_to edit_skill_path(music.text_id)
    else
      if session[:skill][:operation] == :create
        skill = Skill.default(user, music)
      else
        skill = Skill.select_by_user_and_music(user, music)
      end
      load_skill_params(skill)

      begin
        Skill.transaction do
          skill.save!
          skill.skill_scores.each do |score|
            score.save!
          end

          session[:skill] = nil
          redirect_to :skills
        end
      rescue
        redirect_to edit_skill_path(music.text_id)
      end
    end
  end

  def destroy
    music = Music.current

    if params[:no]
      redirect_to edit_skill_path(music.text_id)
    else
      skill = Skill.current

      begin
        Skill.transaction do
          skill.skill_scores.each do |score|
            score.destroy!
          end
          skill.destroy!

          session[:skill] = nil
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
      skill.attributes = session[:skill][:params]
      skill.skill_scores.each do |score|
        difficulty = "difficulty#{score.difficulty}".to_sym
        score.attributes = session[:skill][difficulty]
      end
      skill.calc!
    end
  end
end
