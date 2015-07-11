require 'spec_helper'

require 'test_changes/finding_pattern'

describe TestChanges::FindingPattern do
  let(:matching_pattern) { %r{^lib/test_changes\.rb} }

  subject(:finding_pattern) do
    described_class.new(
      matching_pattern: matching_pattern,
      substitution_patterns: substitution_patterns
    )
  end

  describe "#matching_paths(path)" do
    let(:path) { 'lib/test_changes.rb' }

    let(:expected_match) do
      'spec/fixtures/sample/spec/test_changes/version_spec.rb'
    end

    context "where a substitution pattern is a glob pattern" do
      let(:substitution_pattern) do
        'spec/fixtures/sample/spec/test_changes/*_spec.rb'
      end

      let(:substitution_patterns) { [substitution_pattern] }

      it "returns paths that match both the glob pattern and the given path" do
        results = finding_pattern.matching_paths(path)
        expect(results).to include(expected_match)
      end
    end
  end
end
