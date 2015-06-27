require 'test_changes/error'

module TestChanges
  class InferredConfig
    attr_reader :finding_patterns_map
    attr_reader :runner_name
    attr_reader :project_type_name

    def initialize(runner_name: nil,
      project_type_name: nil, finding_patterns_map: nil)

      @runner_name = runner_name
      @project_type_name = project_type_name
      @finding_patterns_map = finding_patterns_map
    end

    def finding_patterns
      FindingPattern.build finding_patterns_map
    end
  end
end
