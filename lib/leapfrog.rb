# Leapfrog
require 'leapfrog/user_columns'
require 'leapfrog/users'
#require 'leapfrog/leapfrog_observer'

ActiveRecord::ConnectionAdapters::TableDefinition.class_eval do
  include Leapfrog::UserColumns
end

#ActiveRecord::ConnectionAdapters::SchemaStatements.module_eval do
#  include Leapfrog::AlterUserColumns
#end

conn = ActiveRecord::Base::connection
conn.extend Leapfrog::AlterUserColumns

ActiveRecord::Base.class_eval do
  #include Leapfrog::AlterUserColumns
  include Leapfrog::Model::Observe
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
  include Leapfrog::Controller::Users
  #lf_users
end

