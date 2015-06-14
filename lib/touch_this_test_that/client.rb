module TouchThisTestThat
  class Client
    def initialize(*args)
      @args = args
    end

    def call
      puts "\paths_changed_since_commit #{commit}:"
      puts paths_changed_since_commit.inspect

      puts "\nmatches:"
      puts matches.inspect

      puts "\nexisting_matches:"
      puts existing_matches.inspect

      if existing_matches.any?
        puts "\ntest_tool_call:"
        puts test_tool_call
        system(test_tool_call)
      end
    end

    private

    attr_reader :args

    def commit
      @commit ||= args.last || 'HEAD'
    end

    def match_by_pattern
      @match_by_pattern ||= {
        %r{^lib/(.+)\.rb} => 'spec/\1_spec.rb',
        %r{^spec/(.+)_spec.rb} => 'spec/\1_spec.rb'
      }
    end

    def paths_changed_since_commit
      @paths_changed_since_commit ||=
        `git diff --name-only --diff-filter=AMR #{commit}`.split("\n")
    end

    def test_tool_call
      @test_tool_call ||= [
        "rspec",
        test_tool_call_options,
        existing_matches
      ].flatten.compact.join(' ')
    end

    def test_tool_call_options
      @test_tool_call_options ||= args[0, args.size - 1]
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
