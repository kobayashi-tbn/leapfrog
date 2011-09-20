# Leapfrog

# For Rails3.
 require 'active_record/base'
 require 'active_record/connection_adapters/abstract/schema_definitions'
 require 'action_controller/base'
# Add gem 'leapfrog', require => 'active_record' to Gemfile

require 'leapfrog/user_columns'
require 'leapfrog/users'
require 'leapfrog/version'

ActiveRecord::ConnectionAdapters::TableDefinition.class_eval do
  include Leapfrog::UserColumns
end

#ActiveRecord::ConnectionAdapters::SchemaStatements.module_eval do
#  include Leapfrog::AlterUserColumns
#end

conn = ActiveRecord::Base::connection
conn.extend Leapfrog::AlterUserColumns

#ActiveRecord::Base.class_eval do
#  #include Leapfrog::AlterUserColumns
#  include Leapfrog::Model::Observe
#end

ActiveRecord::Base.send :include, Leapfrog::Model::Observe unless ActiveRecord::Base.include?(Leapfrog::Model::Observe)


#ActiveRecord::Base.class_eval do
#  include Leapfrog::Users
#
#  def self.leapfrog(param)
#    puts self
#    attr_accessor param
#  end
#end

#ApplicationController.class_eval do
#  include Leapfrog::Controller::Users
#  #lf_users
#end

#ApplicationController.send :include, Leapfrog::Controller::Users unless ApplicationController.include?(Leapfrog::Controller::Users)
ActionController::Base.send :include, Leapfrog::Controller::Users unless ActionController::Base.include?(Leapfrog::Controller::Users)
