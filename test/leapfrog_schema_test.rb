# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require File.join(File.dirname(__FILE__), 'test_helper')
require File.join(File.dirname(__FILE__), 'dummy/app/models/dummy_todo')
require File.join(File.dirname(__FILE__), 'dummy/app/models/dummy_recipe')

class LeapfrogSchema_test < ActiveSupport::TestCase

  test "userstamps with integer type" do
    
    dummy_todo = DummyTodo.new(:title=> "test")
    user_id = 123
    Thread.current[:user_id] = user_id

    dummy_todo.save
    id = dummy_todo.id
    dummy_todo2 = DummyTodo.find(id)

    assert_kind_of Integer, dummy_todo2.created_by
    assert_kind_of Integer, dummy_todo2.updated_by

  end

  test "userstamps with string type" do
        
    dummy_post = DummyPost.new(:title => "test3")
    username = "test_user"
    Thread.current[:username] = username
    dummy_post.save
    id = dummy_post.id
    dummy_post2 = DummyPost.find(id)

    assert_kind_of String, dummy_post2.created_by
    assert_kind_of String, dummy_post2.updated_by
    
  end
 
end
