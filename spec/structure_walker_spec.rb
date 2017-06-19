require 'spec_helper'

RSpec.describe StructureWalker do
  it 'has a version number' do
    expect(StructureWalker::VERSION).not_to be nil
  end

  describe 'without errors' do

    let(:proc) { ->(data) { data[:new_key] = 'value'; data } }

    subject { StructureWalker::Builder.invoke(proc).call(steps, data) }

    shared_examples 'changed data' do
      it 'change data to result' do
        expect(subject).to eq result
      end
    end

    context 'with empty steps' do
      let(:data) { { key: [{ key: 'value' }] } }
      let(:steps) { [] }
      it 'doesn`t change data' do
        expect(subject).to eq data
      end
    end

    context 'with simple structure' do
      let(:data) { { key: [{ key: 'key' }, { key: 'key' }]} }
      let(:steps) { [:hash, :array] }

      it_behaves_like 'changed data' do
        let(:result) { { key: [{ key: 'key', new_key: 'value' }, { key: 'key', new_key: 'value' }] } }
      end
    end

    context 'with key step' do
      let(:data) { { key: { specific_key: [{ key: 'value' }], another_key: [{ key: 'value' }] } } }
      let(:steps) { [:hash, [:key, :specific_key], :array] }

      it_behaves_like 'changed data' do
        let(:result) { { key: { specific_key: [{ key: 'value', new_key: 'value' }],
                                another_key: [{ key: 'value' }] } } }
      end
    end

    context 'with keys step' do
      let(:data) do
        { key: { specific_key: [{ key: 'value' }],
                 another_key:  [{ key: 'value' }],
                 one_more_key: [{ key: 'value' }] } }
      end

      let(:steps) { [:hash, [:keys, [:specific_key, :one_more_key]], :array] }

      it_behaves_like 'changed data' do
        let(:result) { { key: { specific_key: [{ key: 'value', new_key: 'value' }],
                                another_key:  [{ key: 'value' }],
                                one_more_key: [{ key: 'value', new_key: 'value' }] } } }
      end
    end
  end
end
