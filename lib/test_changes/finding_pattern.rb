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

    def self.build(patterns)
      patterns.map do |pattern, substitution_patterns|
        new(
          matching_pattern: /#{pattern}/,
          substitution_patterns: [substitution_patterns].flatten
        )
      end
    end

    private

    def matches?(path)
      path =~ matching_pattern
    end
  end
end
