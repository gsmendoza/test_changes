require 'test_changes/finding_pattern'

module TestChanges
  class Client
    def initialize(options)
      @runner_name = options[:runner_name]
      @finding_patterns = options[:finding_patterns]
      @commit = options[:commit]
      @runner_call_options = options[:runner_call_options]
      @verbose = options[:verbose]
    end

    # rubocop:disable Metrics/AbcSize
    def call
      log "paths_changed_since_commit #{commit}:",
        paths_changed_since_commit.inspect

      log "matches:", matches.inspect

      log "existing_matches:", existing_matches.inspect

      return if existing_matches.empty?

      log "test_tool_call:", test_tool_call
      system(test_tool_call)
    end
    # rubocop:enable Metrics/AbcSize

    private

    attr_reader :commit,
      :finding_patterns,
      :runner_name,
      :runner_call_options,
      :verbose

    def log(header, message)
      return unless verbose?

      puts "\n#{header}"
      puts message
    end

    def verbose?
      verbose
    end

    def paths_changed_since_commit
      @paths_changed_since_commit ||=
        `git diff --name-only --diff-filter=AMR #{commit}`.split("\n")
    end

    def test_tool_call
      @test_tool_call ||= [
        runner_name,
        runner_call_options,
        existing_matches
      ].flatten.compact.join(' ')
    end

    def existing_matches
      @existing_matches ||= matches.select { |match| File.exist?(match) }
    end

    def matches
      return @matches if @matches

      paths = paths_changed_since_commit

      @matches =
        paths.product(finding_patterns).map do |path, finding_pattern|
          finding_pattern.matching_paths(path)
        end

      @matches = @matches.flatten.uniq
    end
  end
end
