module MrMongo
  class Context
    attr_reader :db, :params

    def initialize(params = {})
      @db     = params[:db]     if params[:db]
      @params = params[:params] if params[:params]
    end

    def params?
      not @params.nil?
    end
  end
end
