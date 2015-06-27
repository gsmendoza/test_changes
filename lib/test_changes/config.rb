require 'test_changes/finding_pattern'
require 'yaml'

module TestChanges
  class Config
    def initialize(config_path)
      @config_path = config_path
    end

    def exists?
      File.exist?(@config_path)
    end

    def finding_patterns
      FindingPattern.build config[runner_name]
    end

    def runner_name
      config.keys.first
    end

    private

    attr_reader :config_path

    def config
      @config ||= YAML.load_file(config_path)
    end
  end
end
