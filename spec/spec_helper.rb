require 'coveralls'
Coveralls.wear!
require 'mr_mongo'
require 'mongo'

RSpec.configure do |c|
  c.filter_run_excluding mongo: true unless ENV['MR_MONGO_RUN_ALL_TESTS']
end

def testing_connection
  ::Mongo::Connection.new('localhost')
end

def testing_database
  testing_connection.db('mr_mongo_test')
end

def drop_testing_database
  testing_connection.drop_database('mr_mongo_test')
end
