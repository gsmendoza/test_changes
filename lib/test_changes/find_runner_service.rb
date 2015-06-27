require 'test_changes/config_setup_service'
require 'test_changes/runner'

module TestChanges
  class FindRunnerService
    def initialize(argv_wrapper)
      @config = ConfigSetupService.call
      @argv_wrapper = argv_wrapper
    end

    def call
      Runner.new(
        name: name,
        finding_patterns: finding_patterns,
        call_options: call_options)
    end

    private

    attr_reader :config, :argv_wrapper

    def name
      argv_wrapper.runner_name || config.runner_name
    end

    def call_options
      argv_wrapper.test_tool_call_options
    end

    def finding_patterns
      config.finding_patterns
    end
  end
end
