module TestChanges
  class Runner
    def initialize(config, argv_wrapper)
      @config = config
      @argv_wrapper = argv_wrapper
    end

    def name
      argv_wrapper.test_tool_command || config.test_tool_command
    end

    def call_options
      argv_wrapper.test_tool_call_options
    end

    private

    attr_reader :config, :argv_wrapper
  end
end
