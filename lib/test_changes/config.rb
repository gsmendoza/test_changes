require 'test_changes/finding_pattern'
require 'test_changes/runner'
require 'yaml'

module TestChanges
  class Config
    def initialize(config_path)
      @config_path = config_path
    end

    def exists?
      File.exist?(@config_path)
    end

    def runners
      config.map do |runner_name, options|
        finding_pattern_maps = options['finding_patterns']

        Runner.new(
          name: runner_name,
          finding_patterns: FindingPattern.build(finding_pattern_maps),
          exclusion_patterns: options['exclude'])
      end
    end

    private

    attr_reader :config_path

    def config
      @config ||= YAML.load_file(config_path)
    end
  end
end
