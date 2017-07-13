# Ribose

[![Build
Status](https://travis-ci.org/riboseinc/ribose-ruby.svg?branch=master)](https://travis-ci.org/riboseinc/ribose-ruby)
[![Code
Climate](https://codeclimate.com/github/riboseinc/ribose-ruby/badges/gpa.svg)](https://codeclimate.com/github/riboseinc/ribose-ruby)

The Ruby Interface to the Ribose API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "ribose"
```

And then execute:

```sh
$ bundle install
```

Or install it yourself as:

```sh
$ gem install ribose
```

## Configure

We need to setup Ribose API configuration before we can perform any request
throughout this client, and to request an API Key please contact Ribose Inc.
Once you have your API key then you can configure it by adding an initializer
with the following code

```ruby
Ribose.configure do |config|
  config.api_key = "SECRET_API_KEY"

  # There are also some default configurations, normally you do not need to
  # change those unless you have some very specific use case scenario. The
  # default response type is `object`, but it also supports other formats
  #
  # config.debug_mode = false
  # config.response_type = :object
  # config.api_host = "https://www.ribose.com"
end
```

Or

```ruby
Ribose.configuration.api_key = "SECRET_API_KEY"
```

## Usage

TODO: Write usage instructions here

## Development

We are following Sandi Metz's Rules for this gem, you can read the
[description of the rules here][sandi-metz] All new code should follow these
rules. If you make changes in a pre-existing file that violates these rules you
should fix the violations as part of your contribution.

### Setup

Clone the repository.

```sh
git clone https://github.com/riboseinc/ribose-ruby
```

Setup your environment.

```sh
bin/setup
```

Run the test suite

```sh
bin/rspec
```

## Contributing

First, thank you for contributing! We love pull requests from everyone. By
participating in this project, you hereby grant [Ribose Inc.][riboseinc] the
right to grant or transfer an unlimited number of non exclusive licenses or
sub-licenses to third parties, under the copyright covering the contribution
to use the contribution by all means.

Here are a few technical guidelines to follow:

1. Open an [issue][issues] to discuss a new feature.
1. Write tests to support your new feature.
1. Make sure the entire test suite passes locally and on CI.
1. Open a Pull Request.
1. [Squash your commits][squash] after receiving feedback.
1. Party!

## Credits

This gem is developed, maintained and funded by [Ribose Inc.][riboseinc]

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[riboseinc]: https://www.ribose.com
[issues]: https://github.com/riboseinc/ribose-ruby/issues
[squash]: https://github.com/thoughtbot/guides/tree/master/protocol/git#write-a-feature
[sandi-metz]: http://robots.thoughtbot.com/post/50655960596/sandi-metz-rules-for-developers
