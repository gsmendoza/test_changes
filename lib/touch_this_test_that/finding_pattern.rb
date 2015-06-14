module TouchThisTestThat
  class FindingPattern
    def initialize(options = {})
      @matching_pattern = options[:matching_pattern]
      @substitution_pattern = options[:substitution_pattern]
    end

    def matching_path(path)
      path.sub(matching_pattern, substitution_pattern) if matches?(path)
     end

    private

    attr_reader :matching_pattern, :substitution_pattern

    def matches?(path)
      path =~ matching_pattern
    end
  end
end
