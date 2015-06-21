module TestChanges
  class FindingPattern
    attr_reader :matching_pattern, :substitution_patterns

    def initialize(options = {})
      @matching_pattern = options[:matching_pattern]
      @substitution_patterns = options[:substitution_patterns]
    end

    def matching_paths(path)
      results = substitution_patterns.map do |substitution_pattern|
        path.sub(matching_pattern, substitution_pattern) if matches?(path)
      end

      results.compact
    end

    private

    def matches?(path)
      path =~ matching_pattern
    end
  end
end
