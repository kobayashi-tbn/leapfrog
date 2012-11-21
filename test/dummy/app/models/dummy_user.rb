class DummyUser < ActiveRecord::Base
  has_many :posts
  leapfrog :user_id
end
