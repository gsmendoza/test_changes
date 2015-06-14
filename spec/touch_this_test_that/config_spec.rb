require 'yaml'
require 'spec_helper'

require 'touch_this_test_that/config'

describe TouchThisTestThat::Config do
  let(:test_tool_command) { 'rspec' }

  let(:pattern_as_string) { '^lib/(.+)\.rb' }
  let(:pattern_as_regular_expression) { %r{^lib/(.+)\.rb} }
  let(:match) { 'spec/\1_spec.rb' }

  let(:config_contents) do
    {
      'test_tool_command' => test_tool_command,
      'match_by_pattern' => {
         pattern_as_string => match
      }
    }
  end

  let(:config_path) { 'tmp/touch_this_test_that.yaml' }

  subject(:config) { described_class.new(config_path) }

  before do
    FileUtils.mkdir_p 'tmp'
    File.write(config_path, YAML.dump(config_contents))
  end

  describe '#test_tool_command' do
    it "is the test_tool_command from the yaml file" do
      expect(config.test_tool_command).to eq(test_tool_command)
    end
  end

  describe '#match_by_pattern' do
    it "converts the keys in the match_by_pattern config into regular expressions" do
      expect(config.match_by_pattern.size).to eq(1)
      expect(config.match_by_pattern.keys.first).to eq(pattern_as_regular_expression)
      expect(config.match_by_pattern.values.first).to eq(match)
    end
  end
end
