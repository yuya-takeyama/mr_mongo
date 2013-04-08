require 'thor'
require 'mongo'
require 'multi_json'
require 'pp'

module MrMongo
  class Application < ::Thor
    DEFAULT_URI = 'mongodb://localhost:27017/test'

    desc 'exec', 'executes MapReduce'
    method_option :db, default: DEFAULT_URI
    method_option :params
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
    method_option :params
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
      context_params = {db: database}
      context_params[:params] = ::MultiJson.load(options[:params]) if options[:params]

      Context.new(context_params)
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
