require 'test_changes/config'
require 'test_changes/inferred_config'

module TestChanges
  module ConfigSetupService
    def self.call
      config_file_name = '.test-changes.yml'
      config = Config.new(config_file_name)

      return config if config.exists?

      if File.exist?('./config/application.rb')
        return use_rspec_rails('./bin/rspec') if File.exist?('./bin/rspec')
        return use_rspec_rails('bundle exec rspec') if File.directory?('./spec')
        return use_testunit_rails('bundle exec ruby -Itest') if File.directory?('./test')
      end

      fail TestChanges::Error, "No #{config_file_name} found"
    end

    private

    def self.use_rspec_rails(bin)
      InferredConfig.new(
        test_tool_command: bin,
        project_type_name: 'rspec_rails',
        finding_patterns_map: {
          '^app/(models)/(.+).rb' => 'spec/\1/\2_spec.rb',
          '^app/(controller|helper|view)s/(.+).rb' => 'spec/controllers/\2_\1_spec.rb'
        }
      )
    end

    def self.use_testunit_rails(bin)
      InferredConfig.new(
        test_tool_command: bin,
        project_type_name: 'testunit_rails',
        finding_patterns_map: {
          '^app/(models)/(.+).rb' => 'test/\1/\2_test.rb',
          '^app/(controller|helper|view)s/(.+).rb' => 'test/controllers/\2_\1_test.rb'
        }
      )
    end
  end
end
