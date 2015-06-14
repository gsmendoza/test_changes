require 'yaml'

module TouchThisTestThat
  class Config
    def initialize(config_path)
      @config_path = config_path
    end

    def match_by_pattern
      pairs = config['match_by_pattern'].map do |pattern, match|
        [/#{pattern}/, match]
      end

      Hash[pairs]
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
