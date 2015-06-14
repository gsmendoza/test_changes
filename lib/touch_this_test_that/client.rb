module TouchThisTestThat
  class Client
    def initialize(options)
      @test_tool_command = options[:test_tool_command]
      @match_by_pattern = options[:match_by_pattern]
      @commit = options[:commit]
      @test_tool_call_options = options[:test_tool_call_options]
      @verbose = options[:verbose].nil? ? true : options[:verbose]
    end

    def call
      log "paths_changed_since_commit #{commit}:",
        paths_changed_since_commit.inspect

      log "matches:", matches.inspect

      log "existing_matches:", existing_matches.inspect

      if existing_matches.any?
        log "test_tool_call:", test_tool_call
        system(test_tool_call)
      end
    end

    private

    attr_reader :commit,
      :match_by_pattern,
      :test_tool_command,
      :test_tool_call_options,
      :verbose

    def log(header, message)
      if verbose?
        puts "\n#{header}"
        puts message
      end
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
        test_tool_command,
        test_tool_call_options,
        existing_matches
      ].flatten.compact.join(' ')
    end

    def existing_matches
      @existing_matches ||= matches.select { |match| File.exist?(match) }
    end

    def matches
      return @matches if @matches

      @matches = paths_changed_since_commit.map do |path|
        matching_patterns = match_by_pattern.select do |pattern, _|
          path =~ pattern
        end

        matching_patterns.map do |pattern, match|
          path.sub(pattern, match)
        end
      end

      @matches = @matches.reduce(:+).compact.uniq
    end
  end
end
