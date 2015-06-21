require 'fileutils'
require 'yaml'
require 'spec_helper'

require 'test_changes/inferred_config'

describe TestChanges::InferredConfig do
  def fixture_path(fixture)
    File.join(File.expand_path('../../../spec/fixtures', __FILE__), fixture)
  end

  context 'rspec-rails' do
    let(:config) do
      Dir.chdir(fixture_path('rspec-rails')) { subject }
    end

    it 'sets the test tool command' do
      expect(config.test_tool_command).to eql './bin/rspec'
    end

    it 'sets finding patterns' do
      expect(config.finding_patterns_map).to be_a Hash
    end
  end
end
