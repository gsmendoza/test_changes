require 'test_changes/runner'

module TestChanges
  class FindRunnerService
    def initialize(argv_wrapper: nil, config: nil)
      @argv_wrapper = argv_wrapper
      @config = config
    end

    def call
      return config.runners.first unless argv_wrapper.runner_name

      config.runners.find do |runner|
        runner.name == argv_wrapper.runner_name
      end
    end

    private

    attr_reader :config, :argv_wrapper
  end
end
