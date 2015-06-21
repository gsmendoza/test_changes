require 'fileutils'
require 'yaml'
require 'spec_helper'

require 'test_changes/inferred_config'

describe TestChanges::InferredConfig do
  let(:finding_patterns_map) { { 'foo' => 'bar' } }
  let(:test_tool_command) { './bin/rspec' }

  subject(:config) do
    described_class.new(
      finding_patterns_map: finding_patterns_map,
      test_tool_command: test_tool_command
    )
  end

  it 'sets the test tool command' do
    expect(config.test_tool_command).to eql './bin/rspec'
  end

  it 'sets finding patterns' do
    expect(config.finding_patterns_map).to eq(finding_patterns_map)
  end
end
