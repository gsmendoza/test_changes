require 'spec_helper'

describe TestChanges::Config do
  let(:runner_name) { 'rspec' }

  let(:pattern_as_string) { '^lib/(.+)\.rb' }
  let(:pattern_as_regular_expression) { %r{^lib/(.+)\.rb} }
  let(:substitution_pattern) { 'spec/\1_spec.rb' }
  let(:substitution_patterns) { [substitution_pattern] }

  let(:finding_patterns_hash) do
    { pattern_as_string => substitution_patterns }
  end

  let(:exclusion_pattern) { 'spec/fixtures/**/*' }

  let(:config_contents) do
    {
      runner_name => {
        'finding_patterns' => finding_patterns_hash,
        'exclude' => [exclusion_pattern]
      }
    }
  end

  let(:config_path) { 'tmp/test-changes.yml' }

  subject(:config) { described_class.new(config_path) }

  let(:runner) do
    expect(config.runners.size).to eq(1)
    config.runners.first
  end

  before do
    FileUtils.mkdir_p 'tmp'
    File.write(config_path, YAML.dump(config_contents))
  end

  describe '#runners' do
    let(:finding_patterns_hash) { {} }

    it "are the runners from the yaml file", :focus do
      expect(runner.name).to eq(runner_name)
      expect(runner.ignore_excluded_files_service.exclusion_patterns)
        .to eq([exclusion_pattern])
    end
  end

  describe '#finding_patterns' do
    shared_examples "builds finding_patterns from the config" do
      it "builds finding_patterns from the config" do
        finding_pattern = runner.finding_patterns.first

        expect(finding_pattern).to be_a(TestChanges::FindingPattern)

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

    context "where the substitution_patterns is a single pattern" do
      let(:substitution_patterns) { substitution_pattern }

      include_examples "builds finding_patterns from the config"
    end
  end
end
