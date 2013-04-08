module MrMongo
  describe Dsl do
    let(:context) { Context.new }
    let(:dsl) { Dsl.new(context) }

    describe '#set' do
      subject { dsl.map_reduce.verbose }

      context 'one is passed as argument' do
        before { dsl.set :verbose, 1 }

        it 'should set its argument to MapReduce object' do
          should eq(1)
        end
      end

      context 'no arguments are passed' do
        before { dsl.set :verbose }

        it { should be_true }
      end
    end

    describe '#params' do
      subject { dsl.params }

      context 'when context has no params' do
        context 'without default params' do
          it { should == {} }
        end

        context 'with default params' do
          before { dsl.default_param 'foo', 'bar' }

          it { should eq({'foo' => 'bar'}) }
        end
      end

      context 'when context has params' do
        let(:context) { Context.new(params: input_params) }
        let(:input_params) { {'hoge' => 'fuga'} }

        context 'without default params' do
          it { should == input_params }
        end

        context 'with default params' do
          context 'no override' do
            before { dsl.default_param 'foo', 'bar' }

            it { should eq({'foo' => 'bar', 'hoge' => 'fuga'}) }
          end

          context 'override' do
            before { dsl.default_param 'hoge', 'piyo' }

            it { should eq({'hoge' => 'fuga'}) }
          end
        end
      end
    end
  end
end
