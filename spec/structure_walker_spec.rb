require 'spec_helper'

RSpec.describe StructureWalker do
  it 'has a version number' do
    expect(StructureWalker::VERSION).not_to be nil
  end

  describe 'without errors' do

    subject { StructureWalker::Builder.invoke(proc).call(steps, data) }

    context 'with simple structure'
    let(:data) { { key: [{ key: 'key' }, { key: 'key' }]} }
    let(:result) { { key: [{ key: 'key', ok: 'data' }, { key: 'key', ok: 'data' }] } }
    let(:proc) { ->(data) { data[:ok] = 'data'; data } }
    let(:steps) { [[:enum, :hash], [:enum, :array]] }

    it 'changes data with proc' do
      expect(subject).to eq result
    end
  end
end
