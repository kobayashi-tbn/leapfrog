# Include hook code here
require 'leapfrog'

ActiveRecord::ConnectionAdapters::TableDefinition.class_eval do
  include Leapfrog::UserColumns
end

ActiveRecord::Base.class_eval do
  include Leapfrog::Users
end
