require 'inline_template_loader'

module MrMongo
  class Loader
    def initialize(context)
      @context = context
    end

    def load(file)
      dsl_script = ::File.read(file).sub!(/^__END__\n.*\Z/m, '')

      map_reduce = load_from_string(dsl_script)

      data_params = InlineTemplateLoader.load(file)

      if data_params
        data_params.each do |key, val|
          map_reduce.send("#{key}=".to_sym, val)
        end
      end

      map_reduce
    end

    def load_from_string(dsl_script, file = "(Mr. Mongo DSL)")
      dsl = Dsl.new(@context)

      eval "dsl.parse {\n" + dsl_script + "\n}.map_reduce", binding, file, 0
    end
  end
end
