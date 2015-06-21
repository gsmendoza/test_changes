require 'test_changes/error'

module TestChanges
  class InferredConfig
    attr_reader :finding_patterns_map
    attr_reader :test_tool_command
    attr_reader :config_path

    def initialize(test_tool_command: nil,
      config_path: nil, finding_patterns_map: nil)

      @test_tool_command = test_tool_command
      @config_path = config_path
      @finding_patterns_map = finding_patterns_map
    end

    def finding_patterns
      FindingPattern.build finding_patterns_map
    end

    def verbose
      true
    end
  end
end
