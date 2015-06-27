require 'test_changes/config_setup_service'

module TestChanges
  class Runner
    def initialize(argv_wrapper)
      @config = ConfigSetupService.call
      @argv_wrapper = argv_wrapper
    end

    def name
      argv_wrapper.test_tool_command || config.test_tool_command
    end

    def call_options
      argv_wrapper.test_tool_call_options
    end

    def finding_patterns
      config.finding_patterns
    end

    private

    attr_reader :config, :argv_wrapper
  end
end
