require 'spec_helper'

require 'test_changes/runner'

describe TestChanges::Runner do
  let(:default_runner_name) { 'rspec' }

  let(:finding_patterns) { [double(:finding_pattern)] }

  let(:config) do
    double(:config,
      finding_patterns: finding_patterns,
      test_tool_command: default_runner_name)
  end

  let(:call_options) { ['--format=documentation'] }
  let(:provided_runner_name) { nil }

  let(:argv_wrapper) do
    double(:argv_wrapper,
      test_tool_command: provided_runner_name,
      test_tool_call_options: call_options)
  end

  subject(:runner) { described_class.new(argv_wrapper) }

  before do
    allow(TestChanges::ConfigSetupService)
      .to receive(:call)
      .and_return(config)
  end

  describe "#name" do
    context "where the user did not provide a runner" do
      let(:provided_runner_name) { nil }

      it "is the first runner from the config" do
        expect(runner.name).to eq(default_runner_name)
      end
    end

    context "where the user provided a runner" do
      let(:provided_runner_name) { 'rubocop' }

      before do
        expect(provided_runner_name).to_not eq(default_runner_name)
      end

      it "is the runner from the config matching the one provided" do
        expect(runner.name).to eq(provided_runner_name)
      end
    end
  end

  describe "#call_options" do
    it "are delegated from the argv_wrapper" do
      expect(runner.call_options).to eq(call_options)
    end
  end

  describe "#finding_patterns" do
    it "are delegated from the config" do
      expect(runner.finding_patterns).to eq(finding_patterns)
    end
  end
end
