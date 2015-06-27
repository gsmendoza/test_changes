require 'slop'
require 'test_changes'

module TestChanges
  class ARGVWrapper
    attr_reader :argv

    def initialize(argv)
      @argv = argv
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
      Slop.parse(argv, help: true, strict: true, banner: banner) do
        on 'c', 'commit=', 'Git commit. Default: HEAD.', default: 'HEAD'
        on 'q', 'quiet', 'Do not print output. Default: false.', default: false

        on 'r', 'runner=',
          'The test tool to run. Default: the first runner of the config file.'
      end
    end

    def banner
      "Usage: test-changes [options] -- [test tool arguments]"
    end
  end
end
