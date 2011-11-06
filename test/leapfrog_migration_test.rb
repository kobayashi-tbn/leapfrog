require File.join(File.dirname(__FILE__), 'test_helper')

require File.join(File.dirname(__FILE__), 'dummy/db/create_recipe')
require File.join(File.dirname(__FILE__), 'dummy/db/add_userstamps_to_recipe')
require File.join(File.dirname(__FILE__), 'dummy/app/models/dummy_recipe')

class LeapfrogTest < ActiveSupport::TestCase  

  test "removed userstamps on recipe table" do
    dummy_recipe = DummyRecipe.new
    assert !dummy_recipe.respond_to?(:created_by)
    assert !dummy_recipe.respond_to?(:updated_by)
  end

  test "added userstamps on post table" do
    dummy_post = DummyPost.new
    assert_respond_to dummy_post, :created_by
    assert_respond_to dummy_post, :updated_by
  end

  test "userstamps exsists on dummy todo table" do
    dummy_todo = DummyTodo.new
    assert_respond_to dummy_todo, :created_by
    assert_respond_to dummy_todo, :updated_by
  end
end
