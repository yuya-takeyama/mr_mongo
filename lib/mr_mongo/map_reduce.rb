module MrMongo
  class MapReduce
    attr_accessor :collection, :map, :reduce, :out, :query, :sort, :limit,
      :finalize, :scope, :js_mode, :verbose

    def initialize(context)
      @context = context
    end
  end
end
