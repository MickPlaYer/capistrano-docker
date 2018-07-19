# Capistrano::Docker

Deploy your rails into docker.

Mount linked dirs and files to volumn and pass command to container.

## Installation

Add this line to your application's Gemfile:

```ruby
group :development do
  gem 'capistrano-docker', require: false
end

```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-docker

## Usage

Require in Capfile to use the default task:

```ruby
require 'capistrano/docker'
```

Defaults

```ruby
set :docker_app_path, '/usr/app'
set :docker_app_port, 80
set :docker_base_image, -> { "#{fetch(:application)}:base" }
set :docker_bins, %w[bundle gem rake rails]
set :docker_filter_label, -> { "app-name=#{fetch(:application)}" }
set :docker_image, -> { fetch(:application) }
set :docker_keep_images, 2
set :dockerfile_base, release_path.join 'Dockerfile.base'
set :dockerfile_template,
    File.expand_path('../templates/Dockerfile.erb', __dir__)
```
About [Dockerfile Template](/lib/capistrano/templates/Dockerfile.erb)

Append `linked_files` and `linked_dirs` for volumn mount

```ruby
append :linked_files, 'config/master.key'
append :linked_dirs, 'node_modules', 'public/packs', 'public/assets'
append :linked_dirs, 'tmp/pids', 'tmp/cache'
```

Append `docker_bins` to run command in container

```ruby
append :docker_bins, 'yarn'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MickPlaYer/capistrano-docker.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
