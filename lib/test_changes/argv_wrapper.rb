require 'slop'
require 'test_changes'

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
      Slop.parse(argv, help: true, strict: true, banner: banner) do
        on 'c', 'commit=', 'Git commit', default: 'HEAD'
      end
    end

    def banner
      "#{SUMMARY}: #{DESCRIPTION}"
    end
  end
end
