# To change this template, choose Tools | Templates
# and open the template in the editor.

module Leapfrog
  module UserColumns
    def users(*args)
      options = args.extract_options!
      self.column(:created_by, :integer, options)
      self.column(:updated_by, :integer, options)
    end
  end
end

