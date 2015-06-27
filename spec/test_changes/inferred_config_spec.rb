require 'fileutils'
require 'yaml'
require 'spec_helper'

require 'test_changes/inferred_config'

describe TestChanges::InferredConfig do
  let(:finding_pattern) { double(:finding_pattern) }
  let(:runner_name) { './bin/rspec' }

  let(:runner) do
    double(:runner, name: runner_name, finding_patterns: [finding_pattern])
  end

  subject(:config) do
    described_class.new([runner])
  end

  it 'sets the test tool command' do
    expect(config.runner_name).to eql './bin/rspec'
  end

  it 'sets finding patterns' do
    expect(config.finding_patterns).to eq([finding_pattern])
  end
end
