module MrMongo
  describe MapReduce do
    let(:context) { Context.new(db: testing_database) }
    let(:map_reduce) { MapReduce.new(context) }

    after { drop_testing_database }

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

    describe 'MapReduce excution', mongo: true do
      let(:expected) do
        [
          {'_id' => 'be', 'value' => 2.0},
          {'_id' => 'not', 'value' => 1.0},
          {'_id' => 'or', 'value' => 1.0},
          {'_id' => 'to', 'value' => 2.0},
        ]
      end

      shared_examples_for 'executes MapReduce correctly' do
        it { should eq(expected) }
      end

      before do
        collection = testing_database.collection('foo')

        collection.insert({word: 'to'})
        collection.insert({word: 'be'})
        collection.insert({word: 'or'})
        collection.insert({word: 'not'})
        collection.insert({word: 'to'})
        collection.insert({word: 'be'})

        map_reduce.collection = 'foo'
        map_reduce.map = <<-EOS
          function () {
            emit(this.word, 1);
          }
        EOS
        map_reduce.reduce = <<-EOS
          function (key, values) {
            var count = 0;

            values.forEach(function (value) {
              count += value;
            });

            return count;
          }
        EOS
      end

      describe '#exec' do
        subject { map_reduce.exec.find.to_a }

        before { map_reduce.out = {replace: 'result'} }

        it_should_behave_like 'executes MapReduce correctly'
      end

      describe '#exec_on_memory' do
        subject { map_reduce.exec_on_memory['results'] }

        it_should_behave_like 'executes MapReduce correctly'
      end
    end
  end
end
