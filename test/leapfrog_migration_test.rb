require File.join(File.dirname(__FILE__), 'test_helper')

require File.join(File.dirname(__FILE__),'dummy/db/create_recipe')
require File.join(File.dirname(__FILE__),'dummy/db/add_userstamps_to_recipe')
require File.join(File.dirname(__FILE__),'dummy/app/models/dummy_recipe')

class LeapfrogTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  include Leapfrog::UserInfo

#  test "the truth" do
#    assert true
#  end

  test "migrate table with userstamps" do
    #@user = User.new(:name => "James", :password => "secret", :email => "james@example.com")
    CreateRecipe.up

#    model = DummyRecipe.new
#    assert_respond_to model, :created_by
#    assert_respond_to model, :updated_by

    assert DummyRecipe.instance_methods.grep 'created_by'
    assert DummyRecipe.instance_methods.grep 'updated_by'
#    assert DummyRecipe.instance_methods.grep 'nothing' == nil
  end

  test "remove and add userstamps" do
    CreateRecipe.up

    AddUserstampsToRecipe.down
    assert DummyRecipe.instance_methods.grep 'created_by' == nil
    assert DummyRecipe.instance_methods.grep 'updated_by' == nil

    AddUserstampsToRecipe.up
    assert DummyRecipe.instance_methods.grep 'created_by'
    assert DummyRecipe.instance_methods.grep 'updated_by'
  end

end
