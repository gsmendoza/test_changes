module TestChanges
  class IgnoreExcludedFilesService
    attr_reader :exclusion_patterns

    def initialize(exclusion_patterns)
      @exclusion_patterns = exclusion_patterns || []
    end

    def call(paths)
      matching_paths = exclusion_patterns.flat_map do |pattern|
        Pathname.glob(pattern)
      end

      paths - matching_paths.map(&:to_s)
    end
  end
end
