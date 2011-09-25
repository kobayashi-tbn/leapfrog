ENV["RAILS_ENV"] = "test"

require 'rubygems'
require 'test/unit'
#require 'active_support'
#require 'active_support/test_case'
#require 'active_record'
#require 'action_controller'

require File.join(File.dirname(__FILE__), '/../lib/leapfrog/user_columns')


require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end


#require 'dummy/app/models/dummy_user'
#require 'dummy/app/models/dummy_todo'


def prepare_test_database
  config = YAML::load( IO.read( File.dirname(__FILE__) + '/database.yml') )

  # Manually initialize the database
  ActiveRecord::Base.configurations = config
  database_name = config['postgresql']['database']
  config['postgresql']['database'] = ''
  ActiveRecord::Base.establish_connection(config['postgresql'])
  conn = ActiveRecord::Base::connection
  #conn = Pg.real_connect( config['postgresql']['host'], config['postgresql']['username'], config['postgresql']['password'] )

  #conn.query( "CREATE DATABASE IF NOT EXISTS #{config['postgresql']['database']}" )
  begin
    conn.query( "CREATE DATABASE #{database_name}" )
  rescue => e
    if e.message =~ /already exists/
      puts e.message
    elsif
      raise e
    end
  end

end

def load_schema
  config = YAML::load( IO.read( File.dirname(__FILE__) + '/database.yml') )

  ActiveRecord::Base.configurations = config
  ActiveRecord::Base.establish_connection( config['postgresql'] )
  ActiveRecord::Base.connection()

  load(File.dirname(__FILE__) + "/dummy/templates/schema.rb")

#  load_fixture( 'dummy_users' )
#  load_fixture( 'dummy_todos' )
end

#def load_fixture( table )
#  fixture = YAML::load( IO.read( File.dirname(__FILE__) + "/fixtures/#{table}.yml") )
#
#  klass = table.camelize.singularize.constantize
#
#  fixture.each do |record_name, record|
#    klass.create( record )
#  end
#
#end

prepare_test_database

require File.join(File.dirname(__FILE__), '/../lib/leapfrog/user_columns')
require File.join(File.dirname(__FILE__), '/../lib/leapfrog/users')
require File.join(File.dirname(__FILE__), '/../lib/leapfrog')

load_schema

