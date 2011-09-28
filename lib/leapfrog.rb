# Leapfrog

# For Rails3.
require 'active_record/base'
require 'active_record/connection_adapters/abstract/schema_definitions'
require 'action_controller/base'
# Add gem 'leapfrog', require => 'active_record' to Gemfile

require 'leapfrog/user_columns'
require 'leapfrog/users'
require 'leapfrog/version'

#ActiveRecord::ConnectionAdapters::TableDefinition.class_eval do
#  include Leapfrog::TableDefinition
#end

ActiveRecord::ConnectionAdapters::TableDefinition.send :include, Leapfrog::TableDefinition unless ActiveRecord::ConnectionAdapters::TableDefinition.include?(Leapfrog::TableDefinition)

#conn = ActiveRecord::Base::connection
#conn.extend Leapfrog::AlterUserColumns
#ActiveRecord::ConnectionAdapters::AbstractAdapter.class_eval do
#  include Leapfrog::AbstractAdapter
#end
ActiveRecord::ConnectionAdapters::AbstractAdapter.send :include, Leapfrog::AbstractAdapter unless ActiveRecord::ConnectionAdapters::AbstractAdapter.include?(Leapfrog::AbstractAdapter)

#ActiveRecord::ConnectionAdapters::SchemaStatements.class_eval do
#  include Leapfrog::AlterUserColumns
#end

#ActiveRecord::ConnectionAdapters::Table.class_eval do
#  def userstamps
#    @base.add_userstamps(@table_name)
#  end
#end
ActiveRecord::ConnectionAdapters::Table.send :include, Leapfrog::Table unless ActiveRecord::ConnectionAdapters::Table.include?(Leapfrog::Table)

ActiveRecord::Base.send :include, Leapfrog::Model::Observe unless ActiveRecord::Base.include?(Leapfrog::Model::Observe)

#ApplicationController.send :include, Leapfrog::Controller::Users unless ApplicationController.include?(Leapfrog::Controller::Users)
ActionController::Base.send :include, Leapfrog::Controller::Users unless ActionController::Base.include?(Leapfrog::Controller::Users)
