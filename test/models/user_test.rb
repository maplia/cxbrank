require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "authenticate" do
    assert_nil User.authenticate('00001', '')
    assert_nil User.authenticate('00001', Digest::SHA1.hexdigest('testuser'))

    result = User.authenticate('00001', 'testuser')
    assert_instance_of User, result
    assert_equal result.username, users(:testuser1).username
  end
end
