module MrMongo
  class Dsl
    attr_reader :map_reduce

    def initialize(context)
      @context        = context
      @map_reduce     = MapReduce.new(context)
      @default_params = {}
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
        @default_params.merge(@context.params)
      else
        @default_params
      end
    end

    def default_param(key, value)
      @default_params[key] = value
    end
  end
end
