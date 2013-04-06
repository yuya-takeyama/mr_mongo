class MrMongo::MapReduce
  attr_accessor :collection, :map, :reduce, :out, :query, :sort, :limit,
    :finalize, :scope, :js_mode, :verbose

  def initialize(params = {})
    @collection = params[:collection]
    @map        = params[:map]
    @reduce     = params[:reduce]
    @out        = params[:out]
    @query      = params[:query]
    @sort       = params[:sort]
    @limit      = params[:limit]
    @finalize   = params[:finalize]
    @scope      = params[:scope]
    @js_mode    = params[:js_mode]
    @verbose    = params[:verbose]
  end
end
