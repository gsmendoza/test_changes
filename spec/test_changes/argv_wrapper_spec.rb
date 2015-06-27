require 'spec_helper'

require 'test_changes/argv_wrapper'

describe TestChanges::ARGVWrapper do
  let(:default_commit) { 'HEAD' }

  subject(:wrapper) { described_class.new(argv) }

  describe "#commit" do
    context "where there are no arguments" do
      let(:argv) { [] }

      it "is HEAD" do
        expect(wrapper.commit).to eq(default_commit)
      end
    end

    context "where there are arguments" do
      let(:argv) { ['-c', commit] }
      let(:commit) { 'HEAD^' }

      it "is the last argument" do
        expect(wrapper.commit).to eq(commit)
      end
    end
  end

  describe "#test_tool_call_options" do
    subject(:test_tool_call_options) { wrapper.test_tool_call_options }

    context "where there are no arguments" do
      let(:argv) { [''] }

      it { expect(test_tool_call_options).to eq([]) }
    end

    context "where there are arguments after --" do
      let(:option) { '--format=progress' }
      let(:argv) { ['--', option] }

      it "is the first to the second to the last option" do
        expect(test_tool_call_options).to eq([option])
      end
    end
  end

  describe "#verbose" do
    context "by default" do
      let(:argv) { [] }
      it { expect(wrapper.verbose?).to eq(true) }
    end

    context "where --quiet option is given" do
      let(:argv) { ['--quiet'] }
      it { expect(wrapper.verbose?).to eq(false) }
    end
  end
end
