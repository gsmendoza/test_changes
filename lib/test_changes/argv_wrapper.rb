module TestChanges
  class ARGVWrapper
    attr_reader :argv

    def initialize(argv)
      @argv = argv
    end

    def commit
      slop_options[:commit]
    end

    def runner_call_options
      runner_call_options_delimiter_index = argv.index('--')

      if runner_call_options_delimiter_index
        argv.slice(runner_call_options_delimiter_index + 1, argv.size)
      else
        []
      end
    end

    def runner_name
      slop_options[:runner]
    end

    def verbose?
      !slop_options.quiet?
    end

    private

    # rubocop:disable Metrics/MethodLength
    def slop_options
      Slop.parse(argv) do |o|
        o.banner = banner
        o.string '-c', '--commit', 'Git commit. Default: HEAD.', default: 'HEAD'
        o.boolean '-q', '--quiet', 'Do not print output. Default: false.', default: false

        o.string '-r', '--runner',
          'The test tool to run. Default: the first runner of the config file.'

        o.on '-h', '--help', 'Display this help message.' do
          puts o
          exit
        end

        o.on '-v', '--version', 'Display the version.' do
          puts VERSION
          exit
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

    def banner
      "Usage: test-changes [options] -- [test tool arguments]"
    end
  end
end
