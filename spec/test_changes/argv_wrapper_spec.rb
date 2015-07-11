require 'spec_helper'

describe TestChanges::ARGVWrapper do
  let(:default_commit) { 'HEAD' }

  subject(:wrapper) do
    described_class.new(argv)
  end

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

  describe "#runner_call_options" do
    subject(:runner_call_options) { wrapper.runner_call_options }

    context "where there are no arguments" do
      let(:argv) { [''] }

      it { expect(runner_call_options).to eq([]) }
    end

    context "where there are arguments after --" do
      let(:option) { '--format=progress' }
      let(:argv) { ['--', option] }

      it "is the first to the second to the last option" do
        expect(runner_call_options).to eq([option])
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

  describe '#runner_name' do
    context "if not provided" do
      let(:argv) { [] }

      it { expect(wrapper.runner_name).to be_nil }
    end

    context "if provided" do
      let(:runner_name) { 'rubocop' }
      let(:argv) { ['-r', runner_name] }

      it "should be the provided test tool command" do
        expect(wrapper.runner_name).to eq(runner_name)
      end
    end
  end
end
