module TouchThisTestThat
  class MatchFinder
    def initialize(options = {})
      @touched_path = options[:touched_path]
      @match_by_pattern = options[:match_by_pattern]
    end

    def matching_paths
      results = match_by_pattern.select do |pattern, _|
        touched_path =~ pattern
      end

      results.map do |pattern, match|
        touched_path.sub(pattern, match)
      end
    end

    private

    attr_reader :touched_path, :match_by_pattern
  end
end
