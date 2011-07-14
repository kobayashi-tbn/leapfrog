require 'test_helper'
require 'leapfrog/users'

class LeapfrogTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  include Leapfrog::UserInfo

#  test "the truth" do
#    assert true
#  end

  test "save_user_id" do
    @user = User.new(:name => "James", :password => "secret", :email => "james@example.com")
    #assert_respond_to(@user, :lf_user_id)

    #@user.lf_user_id = 10
    Leapfrog::UserInfo.current_user_id = 10
    @user.save
    assert_equal(@user.created_by, 10)
    assert_equal(@user.updated_by, nil)

    #@user.lf_user_id = 11
    Leapfrog::UserInfo.current_user_id = 11
    @user.save
    assert_equal(@user.created_by, 10)
    assert_equal(@user.updated_by, 11)
  end

  test "load user and update" do
    @user = User.find(:all).first
    user_id = @user.created_by || 10
    new_user_id = user_id + 1
    #@user.lf_user_id = new_user_id
    Leapfrog::UserInfo.current_user_id = new_user_id
    @user.update_attributes({:email => "new@example.com"})
    assert_equal(@user.updated_by, new_user_id)
  end
end
