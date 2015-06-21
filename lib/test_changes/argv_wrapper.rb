module TestChanges
  class ARGVWrapper
    def initialize(argv)
      @argv = argv
    end

    def commit
      argv.last || 'HEAD'
    end

    def test_tool_call_options
      argv[0, argv.size - 1] || []
    end

    private

    attr_reader :argv
  end
end
