module MrMongo
  class Context
    attr_reader :db

    def initialize(params = {})
      @db = params[:db] if params[:db]
    end
  end
end
