module SkillData
  extend ActiveSupport::Concern

  included do
    def get_skill_data(user, registered_only=false, ignore_locked=false)
      data = {}

      LIST_BLOCKS.each do |key, value|
        data[key] = {
          id: value[:id], title: value[:title], target_count: value[:target_count],
          skills: [], sum_rp: 0.00,
        }
      end

      Skill.select_by_user(user, registered_only, ignore_locked).each do |skill|
        next if registered_only and skill.new_record?

        if skill.music.bonus
          data[:bonus][:skills] << skill
          data[:bonus][:sum_rp] += skill.best_rp
        else
          data[:regular][:skills] << skill
          if data[:regular][:skills].size <= data[:regular][:target_count]
            data[:regular][:sum_rp] += skill.best_rp
          end
        end
      end

      return data
    end
  end
end
