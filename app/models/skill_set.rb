class SkillSet
  include BonusUtil
  attr_reader :block_rps
  attr_reader :total_rp

  SUM_TARGET_SIZES = {
    bonus: -1,
    regular: 20,
  }

  def initialize(skills)
    @blocks = devide_blocks(skills)

    @block_rps = {}
    @total_rp = 0.00

    SUM_TARGET_SIZES.each do |key, size|
      @block_rps[key] = 0.00
      @blocks[key][:items].each_with_index do |item, i|
        break if (size != -1 and i > size) or item.best_rp == 0.00
        @block_rps[key] += item.best_rp
        item.target = true
      end
      @total_rp += @block_rps[key]
    end
  end

  def self.all_by_user(user, options={})
    self.new(Skill.select_by_user(user, options))
  end
end
