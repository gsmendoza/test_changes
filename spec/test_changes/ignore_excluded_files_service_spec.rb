require 'spec_helper'

describe TestChanges::IgnoreExcludedFilesService do
  let(:matching_path) do
    'spec/fixtures/sample/spec/test_changes/version_spec.rb'
  end

  let(:non_matching_path) { 'lib/test_changes.rb' }

  let(:paths) { [matching_path, non_matching_path] }

  let(:exclusion_pattern) { 'spec/fixtures/**/*' }
  let(:exclusion_patterns) { [exclusion_pattern] }

  let(:service) do
    described_class.new(exclusion_patterns)
  end

  describe '#call(files)' do
    context "where a file matches an exclusion pattern" do
      let(:matching_path) do
        'spec/fixtures/sample/spec/test_changes/version_spec.rb'
      end

      it "is rejected" do
        results = service.call(paths)
        expect(results).to_not include(matching_path)
      end
    end

    context "where a file does not match an exclusion pattern" do
      let(:non_matching_path) { 'lib/test_changes.rb' }

      it "is accepted" do
        results = service.call(paths)
        expect(results).to include(non_matching_path)
      end
    end
  end
end
