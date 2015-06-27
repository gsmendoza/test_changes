require 'test_changes/error'

module TestChanges
  class InferredConfig
    attr_reader :runners

    def initialize(runners)
      @runners = runners
    end

    def finding_patterns
      runner.finding_patterns
    end

    def runner_name
      runner.name
    end

    private

    def runner
      runners.first
    end
  end
end
