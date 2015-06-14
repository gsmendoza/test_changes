require 'yaml'

module TouchThisTestThat
  class Config
    def initialize(config_path)
      @config_path = config_path
    end

    def finding_patterns
      config['finding_patterns'].map do |pattern, substitution_pattern|
        FindingPattern.new(
          matching_pattern: /#{pattern}/,
          substitution_pattern: substitution_pattern
        )
      end
    end

    def test_tool_command
      config['test_tool_command']
    end

    def verbose
      config['verbose']
    end

    private

    attr_reader :config_path

    def config
      @config ||= YAML.load_file(config_path)
    end
  end
end
