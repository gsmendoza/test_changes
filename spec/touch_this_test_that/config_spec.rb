require 'fileutils'
require 'yaml'
require 'spec_helper'

require 'touch_this_test_that/config'

describe TouchThisTestThat::Config do
  let(:test_tool_command) { 'rspec' }

  let(:pattern_as_string) { '^lib/(.+)\.rb' }
  let(:pattern_as_regular_expression) { %r{^lib/(.+)\.rb} }
  let(:substitution_pattern) { 'spec/\1_spec.rb' }

  let(:config_contents) do
    {
      'test_tool_command' => test_tool_command,
      'finding_patterns' => finding_patterns_hash
    }
  end

  let(:config_path) { 'tmp/touch_this_test_that.yaml' }

  subject(:config) { described_class.new(config_path) }

  before do
    FileUtils.mkdir_p 'tmp'
    File.write(config_path, YAML.dump(config_contents))
  end

  describe '#test_tool_command' do
    let(:finding_patterns_hash) { {} }

    it "is the test_tool_command from the yaml file" do
      expect(config.test_tool_command).to eq(test_tool_command)
    end
  end

  describe '#finding_patterns' do
    shared_examples "builds finding_patterns from the config" do
      it "builds finding_patterns from the config" do
        expect(config.finding_patterns.size).to eq(1)
        finding_pattern = config.finding_patterns.first

        expect(finding_pattern).to be_a(TouchThisTestThat::FindingPattern)

        expect(finding_pattern.matching_pattern).to eq(pattern_as_regular_expression)
        expect(finding_pattern.substitution_patterns).to eq([substitution_pattern])
      end
    end

    let(:finding_patterns_hash) do
      { pattern_as_string => substitution_patterns }
    end

    context "where the substitution_patterns is an array" do
      let(:substitution_patterns) { [substitution_pattern] }

      include_examples "builds finding_patterns from the config"
    end

    context "where the substitution_patterns is a single pattern", :focus do
      let(:substitution_patterns) { substitution_pattern }

      include_examples "builds finding_patterns from the config"
    end
  end
end
