require 'test_changes/ignore_excluded_files_service'
require 'test_changes/config_setup_service'

module TestChanges
  class Runner
    def initialize(
      name: nil,
      finding_patterns: nil,
      exclusion_patterns: [],
      project_type_name: nil)

      @name = name
      @finding_patterns = finding_patterns
      @exclusion_patterns =  exclusion_patterns
      @project_type_name = project_type_name
    end

    def ignore_excluded_files_service
      @ignore_excluded_files_service ||=
        IgnoreExcludedFilesService.new(exclusion_patterns)
    end

    attr_reader :exclusion_patterns, :name, :finding_patterns, :project_type_name
  end
end
