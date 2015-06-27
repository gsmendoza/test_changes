require 'test_changes/config_setup_service'

module TestChanges
  class Runner
    def initialize(name: nil, finding_patterns: nil)
      @name = name
      @finding_patterns = finding_patterns
    end

    attr_reader :name, :finding_patterns
  end
end
