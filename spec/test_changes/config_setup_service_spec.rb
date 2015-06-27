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

    let(:runner) do
      expect(config.runners.size).to eq(1)
      config.runners.first
    end

    context 'rspec-rails' do
      let(:project_type) { 'rspec-rails' }

      it 'sets the test tool command' do
        expect(runner.name).to eql './bin/rspec'
      end

      it 'sets finding patterns' do
        expect(runner.finding_patterns).to be_an Array
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
