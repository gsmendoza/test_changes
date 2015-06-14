require 'touch_this_test_that/match_finder'

module TouchThisTestThat
  class Client
    def initialize(options)
      @test_tool_command = options[:test_tool_command]
      @match_by_pattern = options[:match_by_pattern]
      @commit = options[:commit]
      @test_tool_call_options = options[:test_tool_call_options]
      @verbose = options[:verbose]
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
      @matches ||= match_finders.map(&:matching_paths).reduce(:+).compact.uniq
    end

    def match_finders
      @match_finders ||= paths_changed_since_commit.map do |path|
        MatchFinder.new(
          touched_path: path,
          match_by_pattern: match_by_pattern
        )
      end
    end
  end
end
