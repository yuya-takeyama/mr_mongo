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

    def set(key, value = true)
      @map_reduce.send("#{key}=", value)
    end

    def verbose(arg = true)
      @map_reduce.verbose = arg
    end

    def js_mode(arg = true)
      @map_reduce.js_mode = arg
    end
  end
end
