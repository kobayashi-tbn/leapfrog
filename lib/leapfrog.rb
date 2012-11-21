# Leapfrog

# For Rails3.
require 'active_record'
require 'active_record/base'
require 'active_record/connection_adapters/abstract/schema_definitions'
require 'action_controller/base'
# Add gem 'leapfrog', require => 'active_record' to Gemfile

require 'leapfrog/user_columns'
require 'leapfrog/users'
require 'leapfrog/version'

ActiveRecord::ConnectionAdapters::TableDefinition.send :include, Leapfrog::TableDefinition unless ActiveRecord::ConnectionAdapters::TableDefinition.include?(Leapfrog::TableDefinition)
ActiveRecord::ConnectionAdapters::AbstractAdapter.send :include, Leapfrog::AbstractAdapter unless ActiveRecord::ConnectionAdapters::AbstractAdapter.include?(Leapfrog::AbstractAdapter)
ActiveRecord::ConnectionAdapters::Table.send :include, Leapfrog::Table unless ActiveRecord::ConnectionAdapters::Table.include?(Leapfrog::Table)

ActiveRecord::Base.send :include, Leapfrog::Model::Observe unless ActiveRecord::Base.include?(Leapfrog::Model::Observe)

ActionController::Base.send :include, Leapfrog::Controller::Users unless ActionController::Base.include?(Leapfrog::Controller::Users)
