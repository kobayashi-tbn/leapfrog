# To change this template, choose Tools | Templates
# and open the template in the editor.

module Leapfrog

  # include for ActiveRecord::ConnectionAdapters::TableDefinition
  module TableDefinition
    def users(*args)
      puts "[Warn] Method users is deprecated. Usage userstamps insted."
      userstamps(args)
    end

    def userstamps(*args)
      options = args.extract_options!
      column(:created_by, :integer, options)
      column(:updated_by, :integer, options)
    end
  end

  # extend for ActiveRecord::Base::connection
  # include for ActiveRecord::ConnectionAdapters::AbstractAdapter
  module AbstractAdapter
    def add_users(table_name, options = {})
      add_column table_name, :created_by, :integer, options
      add_column table_name, :updated_by, :integer, options
    end

    alias_method :add_userstamps, :add_users

    def remove_users(table_name)
      self.remove_column table_name, :created_by
      self.remove_column table_name, :updated_by
    end

    alias_method :remove_userstamps, :remove_users
  end

  module Table
    def userstamps
      @base.add_userstamps(@table_name)
    end

    def remove_userstamps
      @base.remove_userstamps(@table_name)
    end
  end
end

