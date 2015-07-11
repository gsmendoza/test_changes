require 'pathname'
require 'slop'
require 'yaml'

require 'test_changes/argv_wrapper'
require 'test_changes/client'
require 'test_changes/config'
require 'test_changes/config_setup_service'
require 'test_changes/error'
require 'test_changes/finding_pattern'
require 'test_changes/find_runner_service'
require 'test_changes/ignore_excluded_files_service'
require 'test_changes/inferred_config'
require 'test_changes/runner'
require 'test_changes/version'

module TestChanges
  SUMMARY = 'Test Changes'.freeze
  DESCRIPTION =
    'Run only the tests affected by files changed since a given commit.'.freeze
end
