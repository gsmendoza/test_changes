require 'test_changes/config_setup_service'
require 'test_changes/runner'

module TestChanges
  class FindRunnerService
    def initialize(argv_wrapper: nil)
      @config = ConfigSetupService.call
      @argv_wrapper = argv_wrapper
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
