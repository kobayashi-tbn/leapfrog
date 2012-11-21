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
      type = options[:type] || :string
      column(:created_by, type, options)
      column(:updated_by, type, options)
    end
  end

  # extend for ActiveRecord::Base::connection
  # include for ActiveRecord::ConnectionAdapters::AbstractAdapter
  module AbstractAdapter
    def add_users(table_name, *args)
      options = args.extract_options!
      add_column table_name, :created_by, options[:type] || :string, options
      add_column table_name, :updated_by, options[:type] || :string, options
    end

    alias_method :add_userstamps, :add_users

    def remove_users(table_name)
      self.remove_column table_name, :created_by
      self.remove_column table_name, :updated_by
    end

    alias_method :remove_userstamps, :remove_users
  end

  module Table
    def userstamps(*args)
      options = args.extract_options!
      @base.add_userstamps(@table_name, options)
    end

    def remove_userstamps
      @base.remove_userstamps(@table_name)
    end
  end
end

