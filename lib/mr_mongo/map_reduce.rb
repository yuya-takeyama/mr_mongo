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

      options[:raw] = true if defined?(@out) and @out[:inline]

      options
    end
  end
end
