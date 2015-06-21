require 'test_changes/inferred_config'

module TestChanges
  module ConfigSetupService
    def self.call
      config = Config.new('.test_changes.yaml')
      config = InferredConfig.new unless config.exists?
      config
    end
  end
end
