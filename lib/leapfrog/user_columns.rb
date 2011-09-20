# To change this template, choose Tools | Templates
# and open the template in the editor.

module Leapfrog

  # include for ActiveRecord::ConnectionAdapters::TableDefinition
  module UserColumns
    def users(*args)
      puts "[Warn] Method users is deprecated. Usage userstamps insted."
      userstamps(args)
    end

    def userstamps(*args)
      options = args.extract_options!
      self.column(:created_by, :integer, options)
      self.column(:updated_by, :integer, options)
    end
  end

  # extend for ActiveRecord::Base::connection
  module AlterUserColumns
    def add_users(table_name, options = {})
      self.add_column table_name, :created_by, :integer, options
      self.add_column table_name, :updated_by, :integer, options
    end

    alias_method :add_userstamps, :add_users

    def remove_users(table_name)
      self.remove_column table_name, :created_by
      self.remove_column table_name, :updated_by
    end

    alias_method :remove_userstamps, :remove_users
    
  end
end

