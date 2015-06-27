require 'spec_helper'

require 'test_changes/runner'

describe TestChanges::Runner do
  let(:default_runner_name) { 'rspec' }

  let(:config) do
    double(:config, test_tool_command: default_runner_name)
  end

  let(:argv_wrapper) do
    double(:argv_wrapper, test_tool_command: provided_runner_name)
  end

  subject(:runner) { described_class.new(config, argv_wrapper) }

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
end
