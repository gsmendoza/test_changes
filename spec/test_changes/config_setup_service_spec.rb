require 'fileutils'
require 'yaml'
require 'spec_helper'

require 'test_changes/config_setup_service'

describe TestChanges::ConfigSetupService do
  def fixture_path(fixture)
    File.join(File.expand_path('../../../spec/fixtures', __FILE__), fixture)
  end

  describe '.call' do
    subject(:config) do
      Dir.chdir(fixture_path(project_type)) { described_class.call }
    end

    context 'rspec-rails' do
      let(:project_type) { 'rspec-rails' }

      it 'sets the test tool command' do
        expect(config.test_tool_command).to eql './bin/rspec'
      end

      it 'sets finding patterns' do
        expect(config.finding_patterns_map).to be_a Hash
      end
    end

    context 'blank' do
      let(:project_type) { 'blank' }

      it 'raises an error' do
        expect { config }.to raise_error TestChanges::Error
      end
    end
  end
end
