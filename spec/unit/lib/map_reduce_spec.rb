module MrMongo
  describe MapReduce do
    let(:context) { Context.new }
    let(:map_reduce) { MapReduce.new(context) }

    describe '#to_options' do
      subject { map_reduce.to_options }

      context 'some options are specified' do
        before do
          map_reduce.query   = {foo: "bar"}
          map_reduce.limit   = 50
          map_reduce.verbose = true
        end

        it { should eq({query: {foo: "bar"}, limit: 50, verbose: true}) }
      end

      context 'out is inline' do
        before do
          map_reduce.out = {inline: true}
        end

        it { should eq({out: {inline: true}, raw: true}) }
      end
    end
  end
end
