# To change this template, choose Tools | Templates
# and open the template in the editor.

module Leapfrog

  # include for ActiveRecord::ConnectionAdapters::TableDefinition
  module UserColumns
    def users(*args)
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

    def remove_users(table_name)
      self.remove_column table_name, :created_by
      self.remove_column table_name, :updated_by
    end
  end
end

