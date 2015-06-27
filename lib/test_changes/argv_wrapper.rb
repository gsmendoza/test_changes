require 'slop'
require 'test_changes'

module TestChanges
  class ARGVWrapper
    attr_reader :argv, :default_test_tool_command

    def initialize(argv, default_test_tool_command)
      @argv = argv
      @default_test_tool_command = default_test_tool_command
    end

    def commit
      slop_options[:commit]
    end

    def test_tool_call_options
      test_tool_call_options_delimiter_index = argv.index('--')

      if test_tool_call_options_delimiter_index
        argv.slice(test_tool_call_options_delimiter_index + 1, argv.size)
      else
        []
      end
    end

    def test_tool_command
      slop_options[:runner]
    end

    def verbose?
      !slop_options.quiet?
    end

    private

    def slop_options
      wrapper = self

      Slop.parse(argv, help: true, strict: true, banner: banner) do
        on 'c', 'commit=', 'Git commit. Default: HEAD.', default: 'HEAD'
        on 'q', 'quiet', 'Do not print output. Default: false.', default: false

        on 'r', 'runner=',
          'The test tool to run. Default: the first runner of the config file.',
          default: wrapper.default_test_tool_command
      end
    end

    def banner
      "#{SUMMARY}: #{DESCRIPTION}"
    end
  end
end
