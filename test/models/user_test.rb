require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "current" do
    session = {user_id: users(:testuser1).id}
    user = User.current(session)
    assert_instance_of User, user
    assert_equal users(:testuser1).id, user.id
    assert_equal users(:testuser1).username, user.username
  end

  test "find_by_params!" do
    params = {id: '99999'}
    assert_raise ActiveRecord::RecordNotFound do
      User.find_by_params!(params)
    end

    params = {id: sprintf('%05d', users(:testuser1).id)}
    user = User.find_by_params!(params)
    assert_instance_of User, user
    assert_equal users(:testuser1).id, user.id
    assert_equal users(:testuser1).username, user.username
  end

  test "authenticate" do
    user = User.authenticate(users(:testuser1).id, '')
    assert_nil user

    user = User.authenticate(users(:testuser1).id, users(:testuser1).password)
    assert_nil user

    user = User.authenticate('00001', 'testuser')
    assert_instance_of User, user
    assert_equal user.username, users(:testuser1).username
  end

  test "crypt_password!" do
    user = User.new({
      username: 'testuser1', password: 'testuser1', password_confirmation: 'testuser1'
    })
    user.crypt_password!
    assert_equal User.crypt('testuser1'), user.password

    user = User.create!({
      username: 'testuser1', password: 'testuser1', password_confirmation: 'testuser1'
    })
    old_password = user.password.dup
    user.update({password: user.password, password_confirmation: user.password})
    user.crypt_password!
    assert_equal old_password, user.password
    assert_equal User.crypt('testuser1'), user.password

    user = User.create!({
      username: 'testuser1', password: 'testuser1', password_confirmation: 'testuser1'
    })
    old_password = user.password.dup
    user.update({password: 'testuser2', password_confirmation: 'testuser2'})
    user.crypt_password!
    assert_not_equal old_password, user.password
    assert_equal User.crypt('testuser2'), user.password
  end

  test "save!" do
    user = User.new({
      username: 'testuser1', password: 'testuser1', password_confirmation: 'testuser1'
    })
    user.save!
    assert_not_equal 'testuser1', user.password
    assert_equal User.crypt('testuser1'), user.password
  end
end
