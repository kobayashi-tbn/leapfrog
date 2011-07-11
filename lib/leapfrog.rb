# Leapfrog
require 'leapfrog/user_info'
require 'observer'
require 'leapfrog/user_columns'
#require 'leapfrog/users'


ActiveRecord::ConnectionAdapters::TableDefinition.class_eval do
  include Leapfrog::UserColumns
end

#ActiveRecord::Base.class_eval do
#  include Leapfrog::Users
#
#  def self.leapfrog(param)
#    puts self
#    attr_accessor param
#  end
#end

ApplicationController.class_eval do
  include Leapfrog::UserInfo

  before_filter :set_lf_user_id

  def set_lf_user_id
    UserInfo.current_user_id = session[:user_id]
  end

end