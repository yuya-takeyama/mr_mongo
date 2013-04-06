module MrMongo
  describe Dsl do
    let(:context) { Context.new }
    let(:dsl) { Dsl.new(context) }

    describe '#verbose' do
      subject { dsl.map_reduce.verbose }

      context 'true is passed as argument' do
        before { dsl.verbose true }

        it { should be_true }
      end

      context 'false is passed as argument' do
        before { dsl.verbose false }

        it { should be_false }
      end

      context 'argument is omitted' do
        before { dsl.verbose }

        it { should be_true }
      end
    end

    describe '#js_mode' do
      subject { dsl.map_reduce.js_mode }

      context 'true is passed as argument' do
        before { dsl.js_mode true }

        it { should be_true }
      end

      context 'false is passed as argument' do
        before { dsl.js_mode false }

        it { should be_false }
      end

      context 'argument is omitted' do
        before { dsl.js_mode }

        it { should be_true }
      end
    end
  end
end
