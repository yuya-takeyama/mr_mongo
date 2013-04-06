require 'spec_helper'

module MrMongo
  describe Loader do
    let(:loader) { Loader.new(Context.new) }

    describe '#load_from_string' do
      subject { loader.load_from_string(dsl_script) }

      context 'some parameters are set' do
        let(:dsl_script) do
          <<-EOS
            collection "foo"
            out "bar"
            verbose true
          EOS
        end

        its(:collection) { should eq('foo') }
        its(:out)        { should eq('bar') }
        its(:verbose)    { should be_true }
      end

      context 'no parameters are set' do
        let(:dsl_script) { '' }

        its(:collection) { should be_nil }
        its(:out)        { should be_nil }
        its(:verbose)    { should be_nil }
      end
    end

    describe '#load' do
      subject { loader.load(File.expand_path(File.join(__FILE__, '../../../../fixtures/fixture_dsl.rb'))) }

      its(:collection) { should eq('foo') }
      its(:out)        { should eq('bar') }
      its(:verbose)    { should be_true }
      its(:map)        { should eq("function () { emit(this.id, this.count); }\n") }
      its(:reduce)     { should eq("function (key, values) { return 0; }\n") }
    end
  end
end
