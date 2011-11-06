class DummyUser < ActiveRecord::Base
  has_many :posts
  leapfrog_user_id
end
