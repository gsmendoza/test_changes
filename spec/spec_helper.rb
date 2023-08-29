$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'test_changes'

RSpec.configure do |config|
	config.example_status_persistence_file_path = 'tmp/examples.txt'
end