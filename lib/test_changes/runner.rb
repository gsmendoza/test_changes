require 'test_changes/config_setup_service'

module TestChanges
  class Runner
    def initialize(name: nil, finding_patterns: nil, project_type_name: nil)
      @name = name
      @finding_patterns = finding_patterns
      @project_type_name = project_type_name
    end

    attr_reader :name, :finding_patterns, :project_type_name
  end
end
