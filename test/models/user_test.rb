require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "authenticate" do
    assert_nil User.authenticate('00001', '')
    assert_nil User.authenticate('00001', Digest::SHA1.hexdigest('testuser'))
    assert_not_nil User.authenticate('00001', 'testuser')
  end
end
