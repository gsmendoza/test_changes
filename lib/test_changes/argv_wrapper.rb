require 'slop'

module TestChanges
  class ARGVWrapper
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

    private

    attr_reader :argv

    def slop_options
      Slop.parse(argv) do
        on 'c', 'commit=', 'Git commit', default: 'HEAD'
      end
    end
  end
end
