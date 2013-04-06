module MrMongo
  class Dsl
    attr_reader :map_reduce

    def initialize
      @map_reduce = MapReduce.new
    end

    def parse(&block)
      instance_eval &block
      
      self
    end

    %w{collection map reduce out query sort limit finalize scope js_mode verbose}.each do |s|
      define_method(s) {|arg| @map_reduce.send("#{s}=", arg) }
    end
  end
end
