require File.join(File.dirname(__FILE__), 'test_helper')

require File.join(File.dirname(__FILE__), 'dummy/app/models/dummy_user')
require File.join(File.dirname(__FILE__), 'dummy/app/models/dummy_todo')

class LeapfrogTest < ActiveSupport::TestCase
  include Leapfrog::UserInfo

  test "save user_id to todo" do
    @todo = DummyTodo.new(:title => "new todo", :description => "refactoring", :limit_on => Date.today)

    _created_by = 10

    #Leapfrog::UserInfo.current_user_id = _created_by
    Thread.current[:user_id] = _created_by
    @todo.save
    assert_equal(@todo.created_by, _created_by)
    assert_equal(@todo.updated_by, _created_by)

    _updated_by = 11

    #Leapfrog::UserInfo.current_user_id = _updated_by
    Thread.current[:user_id] = _updated_by
    @todo.save
    assert_equal(@todo.created_by, _created_by)
    assert_equal(@todo.updated_by, _updated_by)
  end

end
