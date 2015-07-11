require 'spec_helper'

describe TestChanges::FindRunnerService do
  let(:default_runner_name) { 'rspec' }

  let(:finding_patterns) { [double(:finding_pattern)] }

  let(:config_runners) do
    [
      double(:runner,
        finding_patterns: finding_patterns,
        name: default_runner_name),
      double(:runner,
        finding_patterns: finding_patterns,
        name: provided_runner_name)
    ]
  end

  let(:config) do
    double(:config, runners: config_runners)
  end

  let(:provided_runner_name) { nil }

  let(:argv_wrapper) do
    double(:argv_wrapper,
      runner_name: provided_runner_name)
  end

  subject(:service) do
    described_class.new(
      argv_wrapper: argv_wrapper,
      config: config)
  end

  let(:runner) { service.call }

  describe "#call" do
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
end
