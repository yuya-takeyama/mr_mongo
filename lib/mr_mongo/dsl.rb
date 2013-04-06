module MrMongo
  class Dsl
    attr_reader :map_reduce

    def initialize(context)
      @map_reduce = MapReduce.new(context)
    end

    def parse(&block)
      instance_eval &block
      
      self
    end

    %w{collection map reduce out query sort limit finalize scope}.each do |s|
      define_method(s) {|arg| @map_reduce.send("#{s}=", arg) }
    end

    def verbose(arg = true)
      @map_reduce.verbose = arg
    end

    def js_mode(arg = true)
      @map_reduce.js_mode = arg
    end
  end
end
