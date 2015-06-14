require 'touch_this_test_that/finding_pattern'

module TouchThisTestThat
  class MatchFinder
    def initialize(options = {})
      @touched_path = options[:touched_path]
      @finding_patterns =
        options[:finding_patterns].map do |matching_pattern, substitution_pattern|
          FindingPattern.new(
            matching_pattern: matching_pattern,
            substitution_pattern: substitution_pattern
          )
      end
    end

    def matching_paths
      results = finding_patterns.map do |finding_pattern|
        finding_pattern.matching_path(touched_path)
      end

      results.compact
    end

    private

    attr_reader :touched_path, :finding_patterns
  end
end
