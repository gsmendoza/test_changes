require 'test_changes/inferred_config'

module TestChanges
  module ConfigSetupService
    def self.call
      config = Config.new('.test_changes.yaml')

      unless config.exists?
        config = (
          if File.exist?('./config/application.rb')
            if File.exist?('./bin/rspec')
              use_rspec_rails('./bin/rspec')
            elsif File.directory?('./spec')
              use_rspec_rails('bundle exec rspec')
            elsif File.directory?('./test')
              use_testunit_rails('bundle exec ruby -Itest')
            end
          else
            fail TestChanges::Error, "No .test_changes.yaml found"
          end
        )
      end

      config
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
