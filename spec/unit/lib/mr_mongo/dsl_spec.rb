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
        it { should == {} }
      end

      context 'when context has params' do
        let(:context) { Context.new(params: input_params) }
        let(:input_params) { {"foo" => "bar"} }

        it { should == input_params }
      end
    end
  end
end
