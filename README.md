# Test Changes

Test files that have changed since a given commit.

[![Status](https://travis-ci.org/gsmendoza/test_changes.svg?branch=master)](https://travis-ci.org/gsmendoza/test_changes "See test builds")

## Requirements

* [Git](https://git-scm.com)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'test_changes', require: false
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install test_changes

## Configuration

Add a `.test-changes.yml` configuration file to your repo. Example:

```yaml
---
rspec:
  finding_patterns:
    ^lib/(.+)\.rb: spec/\1_spec.rb
    ^spec/(.+)_spec.rb: spec/\1_spec.rb
  exclude:
    - spec/fixtures/**/*
rubocop:
  finding_patterns:
    ^(.+)\.rb: \1.rb
```

At the root of the file, we have the commands for running the tests. Examples: `rspec`, `zeus rspec`, `rubocop`.

These are the options under each command:

* finding_patterns - If the name of a changed file matches
  the regular expression, `test_changes` will test the file's matching tests.
  Can accept an array of tests:

    ```yaml
    rspec:
      finding_patterns:
        ^lib/test_changes\.rb:
        - spec/test_changes_spec.rb
        - spec/test_changes/*_spec.rb
    ```

  The values can also be glob patterns.

* exclude - Patterns of files that should be excluded from the run.

## Usage

`test-changes -c [commit] -- [test_tool_arguments]`

* `test_tool_arguments` - Arguments that can be passed to the test tool.

* `commit` - Test change from this commit. Defaults to HEAD.

See `test-changes -h` for more options.

Examples:

```
test-changes
test-changes -c master
test-changes -c HEAD^ -- --format=documentation
```

## Known to work on

* Ruby 2.0.0
* Git 2.3.5

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

IMPORTANT: Please use [RuboCop](https://github.com/bbatsov/rubocop) and [Overcommit](https://github.com/brigade/overcommit) when submitting pull requests.

1. Fork it ( https://github.com/gsmendoza/test_changes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
