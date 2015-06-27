require 'test_changes/config_setup_service'

module TestChanges
  class Runner
    def initialize(name: nil, finding_patterns: nil, call_options: nil)
      @name = name
      @finding_patterns = finding_patterns
      @call_options = call_options
    end

    attr_reader :name, :finding_patterns, :call_options
  end
end
