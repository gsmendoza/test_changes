require 'fileutils'
require 'yaml'
require 'spec_helper'

require 'test_changes/inferred_config'

describe TestChanges::InferredConfig do
  def fixture_path(fixture)
    File.join(File.expand_path('../../../spec/fixtures', __FILE__), fixture)
  end

  describe 'rspec-rails' do
    let(:config) {
      Dir.chdir(fixture_path('rspec-rails')) { subject }
    }

    it 'sets the test tool command' do
      expect(config.test_tool_command).to eql './bin/rspec'
    end

    it 'sets finding patterns' do
      expect(config.finding_patterns_map).to be_a Hash
    end
  end

  describe 'blank' do
    let(:config) {
      Dir.chdir(fixture_path('blank')) { subject }
    }

    it 'raises an error' do
      expect { config }.to raise_error TestChanges::Error
    end
  end
end
