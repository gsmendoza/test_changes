require 'spec_helper'

require 'touch_this_test_that/client'

describe TouchThisTestThat::Client do
  subject(:client) { described_class.new(*args) }

  describe "#call" do
    let(:git_diff_call) do
      "git diff --name-only --diff-filter=AMR #{commit}"
    end

    let(:changed_file_path) { 'lib/touch_this_test_that/client.rb' }

    let(:test_tool_command) { 'rspec' }

    let(:matching_file_path) { 'spec/touch_this_test_that/client_spec.rb' }

    let(:test_tool_call) do
      "#{test_tool_command} #{matching_file_path}"
    end

    context "where there are no arguments" do
      let(:args) { [] }

      let(:commit) { 'HEAD' }

      it "runs the test tool on tests matching files changed since HEAD" do
        expect(subject)
          .to receive(:`).with(git_diff_call)
          .and_return(changed_file_path)

        expect(subject).to receive(:system).with(test_tool_call)

        expect(File).to receive(:exist?).with(matching_file_path).and_return(true)

        client.call
      end
    end
  end
end