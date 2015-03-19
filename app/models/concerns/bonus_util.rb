module BonusUtil
  extend ActiveSupport::Concern
  include Enumerable
  
  included do
    def devide_blocks(items)
      blocks = {}
      LIST_BLOCKS.each do |key, data|
        blocks[key] = {
          id: data[:id], title: data[:title], items: [],
        }
      end
      
      items.each do |item|
        if item.bonus?
          blocks[:bonus][:items] << item
        else
          blocks[:regular][:items] << item
        end
      end

      blocks
    end

    def each
      @blocks.each_value do |block|
        yield block
      end
    end
  end
end