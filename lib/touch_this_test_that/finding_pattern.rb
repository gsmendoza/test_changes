module TouchThisTestThat
  class FindingPattern
    attr_reader :matching_pattern, :substitution_pattern

    def initialize(options = {})
      @matching_pattern = options[:matching_pattern]
      @substitution_pattern = options[:substitution_pattern]
    end

    def matching_paths(path)
      if matches?(path)
        [path.sub(matching_pattern, substitution_pattern)]
      else
        []
      end
    end

    private

    def matches?(path)
      path =~ matching_pattern
    end
  end
end
