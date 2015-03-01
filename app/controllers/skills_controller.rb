class SkillsController < ApplicationController
  def index
    @bonus_skills = Skill.bonus_skills(session[:user].id)
    raise @bonus_skills.first.to_s
  end
end
