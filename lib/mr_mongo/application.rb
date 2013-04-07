require 'thor'
require 'mongo'
require 'pp'

module MrMongo
  class Application < ::Thor
    DEFAULT_URI = 'mongodb://localhost:27017/test'

    desc 'exec', 'executes MapReduce'
    method_option :db, default: DEFAULT_URI
    def exec(*files)
      files.each do |file|
        puts "Executing #{file}..."
        pp loader.load(file).exec
        puts
      end

      puts "Finished MapReduce execution."
    end

    desc 'exec_on_memory', 'executes MapReduce on memory'
    method_option :db, default: DEFAULT_URI
    def exec_on_memory(*files)
      files.each do |file|
        puts "Executing #{file} on memory..."
        pp loader.load(file).exec_on_memory
        puts
      end

      puts "Finished MapReduce execution (on memory)."
    end

    private
    def loader
      Loader.new(context)
    end

    def context
      Context.new(db: database)
    end

    def database
      path = URI.parse(options[:db]).path
      database_name = if path =~ %r{^/([^/]+)}
        $1
      else
        'test'
      end

      ::Mongo::MongoClient.from_uri(options[:db]).db(database_name)
    end
  end
end
