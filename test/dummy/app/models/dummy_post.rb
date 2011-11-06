class DummyPost < ActiveRecord::Base
  belongs_to :users
  leapfrog :username
end
