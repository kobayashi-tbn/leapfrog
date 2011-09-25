require File.join(File.dirname(__FILE__), 'test_helper')



require File.join(File.dirname(__FILE__),'dummy/app/models/dummy_user')
require File.join(File.dirname(__FILE__),'dummy/app/models/dummy_todo')

class LeapfrogTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  include Leapfrog::UserInfo

#  test "the truth" do
#    assert true
#  end

  test "save user_id to users" do
    #@user = User.new(:name => "James", :password => "secret", :email => "james@example.com")
    @user = DummyUser.new(:name => "James", :password => "secret", :email => "james@example.com")

    _created_by = rand(100)
    Leapfrog::UserInfo.current_user_id = _created_by
    @user.save
    assert_equal(@user.created_by, _created_by)
    assert_equal(@user.updated_by, nil)

    _updated_by = rand(100)+100
    Leapfrog::UserInfo.current_user_id = _updated_by
    @user.save
    assert_equal(@user.created_by, _created_by)
    assert_equal(@user.updated_by, _updated_by)
  end

  test "load user and update user_id" do
    @user = DummyUser.new(:name => "James", :password => "secret", :email => "james@example.com")
    Leapfrog::UserInfo.current_user_id = rand(100)
    @user.save

    @user = DummyUser.find(:all, :order => 'updated_at desc').first
    user_id = @user.created_by
    new_user_id = user_id + 1
    #@user.lf_user_id = new_user_id
    Leapfrog::UserInfo.current_user_id = new_user_id
    @user.update_attributes({:email => "new@example.com"})
    assert_equal(@user.updated_by, new_user_id)
  end

  test "save user_id to todo" do
    @todo = DummyTodo.new(:title => "new todo", :description => "refactoring", :limit_on => Date.today)

    #@user.lf_user_id = 10
    Leapfrog::UserInfo.current_user_id = 10
    @todo.save
    assert_equal(@todo.created_by, 10)
    assert_equal(@todo.updated_by, nil)

    #@user.lf_user_id = 11
    Leapfrog::UserInfo.current_user_id = 11
    @todo.save
    assert_equal(@todo.created_by, 10)
    assert_equal(@todo.updated_by, 11)
  end

  test "load todo and update user_id" do
    @todo = DummyTodo.new(:title => "new todo", :description => "refactoring", :limit_on => Date.today)
    Leapfrog::UserInfo.current_user_id = 15
    @todo.save

    @todo = DummyTodo.find(:all, :order => "updated_at desc").first
    user_id = @todo.created_by
    new_user_id = user_id + 1
    #@user.lf_user_id = new_user_id
    Leapfrog::UserInfo.current_user_id = new_user_id
    @todo.update_attributes({:complete => true})
    assert_equal(@todo.updated_by, new_user_id)
  end

end
