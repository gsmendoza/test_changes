module TouchThisTestThat
  class Client
    def call
      puts "\paths_changed_since_commit:"
      puts paths_changed_since_commit.inspect

      puts "\nmatches:"
      puts matches.inspect

      puts "\nexisting_matches:"
      puts existing_matches.inspect

      system("rspec #{existing_matches.join(' ')}") if existing_matches.any?
    end

    private

    def commit
      'HEAD'
    end

    def match_by_pattern
      @match_by_pattern ||= {
        %r{^lib/(.+)\.rb} => 'spec/\1_spec.rb'
      }
    end

    def paths_changed_since_commit
      @paths_changed_since_commit ||=
        `git diff --name-only --diff-filter=AMR #{commit}`.split("\n")
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
