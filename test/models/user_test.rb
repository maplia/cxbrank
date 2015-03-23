require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "authenticate" do
    assert_nil User.authenticate('00001', '')
    assert_nil User.authenticate('00001', Digest::SHA1.hexdigest('testuser'))

    user = User.authenticate('00001', 'testuser')
    assert_instance_of User, user
    assert_equal user.username, users(:testuser1).username
  end

  test "crypt_password!" do
    user = User.new({
      username: 'testuser1', password: 'testuser1', password_confirmation: 'testuser1'
    })
    user.crypt_password!
    assert_equal Digest::SHA1.hexdigest('testuser1'), user.password

    user = User.create!({
      username: 'testuser1', password: 'testuser1', password_confirmation: 'testuser1'
    })
    old_password = user.password.dup
    user.update({password: user.password, password_confirmation: user.password})
    user.crypt_password!
    assert_equal old_password, user.password
    assert_equal Digest::SHA1.hexdigest('testuser1'), user.password

    user = User.create!({
      username: 'testuser1', password: 'testuser1', password_confirmation: 'testuser1'
    })
    old_password = user.password.dup
    user.update({password: 'testuser2', password_confirmation: 'testuser2'})
    user.crypt_password!
    assert_not_equal old_password, user.password
    assert_equal Digest::SHA1.hexdigest('testuser2'), user.password
  end

  test "save!" do
    user = User.create!({
      username: 'testuser1', password: 'testuser1', password_confirmation: 'testuser1'
    })
    assert_not_equal 'testuser1', user.password
    assert_equal Digest::SHA1.hexdigest('testuser1'), user.password
  end
end
