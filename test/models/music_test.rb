require 'test_helper'

class MusicTest < ActiveSupport::TestCase
  test "current" do
    session = {skill: {music_id: 1}}
    music = Music.current(session)
    assert_instance_of Music, music
  end

  test "find_by_params!" do
    params = {}
    assert_raise ActiveRecord::RecordNotFound do
      Music.find_by_params!(params)
    end

    params = {id: 'orehabeatmaniaomaehananimania'}
    assert_raise ActiveRecord::RecordNotFound do
      Music.find_by_params!(params)
    end

    params = {id: 'somedayinst'}
    music = Music.find_by_params!(params)
    assert_instance_of Music, music
  end
end
