require 'touch_this_test_that/finding_pattern'

module TouchThisTestThat
  class MatchFinder
    def initialize(options = {})
      @touched_path = options[:touched_path]
      @match_by_pattern = options[:match_by_pattern]
    end

    def matching_paths
      finding_patterns = match_by_pattern.map do |matching_pattern, substitution_pattern|
        FindingPattern.new(
          matching_pattern: matching_pattern,
          substitution_pattern: substitution_pattern
        )
      end

      matching_finding_patterns = finding_patterns.select do |finding_pattern|
        finding_pattern.matches?(touched_path)
      end

      matching_finding_patterns.map do |finding_pattern|
        finding_pattern.matching_path(touched_path)
      end
    end

    private

    attr_reader :touched_path, :match_by_pattern
  end
end
