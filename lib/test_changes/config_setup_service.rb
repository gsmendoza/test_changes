require 'test_changes/inferred_config'

module TestChanges
  module ConfigSetupService
    def self.call
      config = Config.new('.test_changes.yaml')
      config = InferredConfig.new unless config.exists?

      if config.test_tool_command.nil?
        fail TestChanges::Error, "No .test_changes.yaml found"
      end

      config
    end
  end
end
