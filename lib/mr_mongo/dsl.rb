module MrMongo
  class Dsl
    attr_reader :map_reduce

    def initialize(context)
      @context    = context
      @map_reduce = MapReduce.new(context)
    end

    def parse(&block)
      instance_eval &block
      
      self
    end

    def set(key, value = true)
      @map_reduce.send("#{key}=", value)
    end

    def params
      if @context.params?
        @context.params
      else
        {}
      end
    end
  end
end
