module TouchThisTestThat
  class Client
    def call
      commit = 'HEAD'

      match_by_pattern = {
        %r{^lib/(.+)\.rb} => 'spec/\1_spec.rb'
      }

      paths_changed_since_commit =
        `git diff --name-only --diff-filter=AMR #{commit}`.split("\n")

      puts "\paths_changed_since_commit:"
      puts paths_changed_since_commit.inspect

      matches = paths_changed_since_commit.map do |path|
        matching_patterns = match_by_pattern.select do |pattern, _|
          path =~ pattern
        end

        matching_patterns.map do |pattern, match|
          path.sub(pattern, match)
        end
      end

      matches = matches.reduce(:+).compact.uniq

      puts "\nmatches:"
      puts matches.inspect

      existing_matches = matches.select { |match| File.exist?(match) }

      puts "\nexisting_matches:"
      puts existing_matches.inspect

      if existing_matches.any?
        system("rspec #{existing_matches.join(' ')}")
      end
    end
  end
end
