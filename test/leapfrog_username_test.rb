require File.join(File.dirname(__FILE__), 'test_helper')

require File.join(File.dirname(__FILE__), 'dummy/db/create_post')
require File.join(File.dirname(__FILE__), 'dummy/app/models/dummy_post')

class LeapfrogUsernameTest < ActiveSupport::TestCase
  include Leapfrog::UserInfo

  test "save user_id to posts" do
    @post = DummyPost.new(:title => "New Post", :article => "First Article")

    _created_by = "gaga"

    Leapfrog::UserInfo.current_user=({Leapfrog::UserInfo::USERSTAMP_MAP[:name] => _created_by})
    @post.save
    assert_equal(@post.created_by, _created_by)
    assert_equal(@post.updated_by, _created_by)

    _updated_by = "michael"
    
    Leapfrog::UserInfo.current_user=({Leapfrog::UserInfo::USERSTAMP_MAP[:name] => _updated_by})
    @post.save
    assert_equal(@post.created_by, _created_by)
    assert_equal(@post.updated_by, _updated_by)
  end

end
