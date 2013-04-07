module MrMongo
  class MapReduce
    attr_accessor :collection, :map, :reduce, :out, :query, :sort, :limit,
      :finalize, :scope, :js_mode, :verbose

    def initialize(context)
      @context = context
    end

    def to_options
      options = {}

      options[:query]    = @query    if defined?(@query)
      options[:sort]     = @sort     if defined?(@sort)
      options[:limit]    = @limit    if defined?(@limit)
      options[:finalize] = @finalize if defined?(@finalize)
      options[:out]      = @out      if defined?(@out)
      options[:verbose]  = @verbose  if defined?(@verbose)

      options[:raw] = true if defined?(@out) and @out.is_a?(::Hash) and @out[:inline]

      options
    end

    def exec
      exec_with_options(to_options)
    end

    def exec_on_memory
      options = to_options
      options[:out] = {inline: true}
      options[:raw] = true

      exec_with_options(options)
    end

    def insert_into_collection(*args)
      mongo_collection.send(:insert, *args)
    end

    private
    def exec_with_options(options)
      mongo_collection.map_reduce(@map, @reduce, options)
    end

    def mongo_collection
      @context.db.collection(@collection)
    end
  end
end
