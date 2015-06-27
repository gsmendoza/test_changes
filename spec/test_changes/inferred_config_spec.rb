require 'fileutils'
require 'yaml'
require 'spec_helper'

require 'test_changes/inferred_config'

describe TestChanges::InferredConfig do
  let(:finding_patterns_map) { { 'foo' => 'bar' } }
  let(:runner_name) { './bin/rspec' }

  subject(:config) do
    described_class.new(
      finding_patterns_map: finding_patterns_map,
      runner_name: runner_name
    )
  end

  it 'sets the test tool command' do
    expect(config.runner_name).to eql './bin/rspec'
  end

  it 'sets finding patterns' do
    expect(config.finding_patterns_map).to eq(finding_patterns_map)
  end
end
