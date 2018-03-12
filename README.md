# Finfolio

Ruby API Client for easy interaction with Finfolio data. 

## Quick Start

Install via Rubygems

```ruby
gem 'finfolio'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install finfolio

## Configuration

```ruby
# Provide the Finfolio API Key and the desired Finfolio URL origin.
Finfolio::API::Client.new(Figaro.env.finfolio_api_key!, Figaro.env.finfolio_url!)
```

## Usage

### Retrieve a list of Managers

```ruby
client = Finfolio::API::Client.new(Figaro.env.finfolio_api_key!, Figaro.env.finfolio_url!)

client.managers
```

### Retrieve a single Account

```ruby
client.account(account_id)
```

### Customize the response

Finfolio gives us the oppurtunity to customize the scope of the response. (Customization varies per endpoint)

```ruby
client.account(account_id, fields: "Name, FileAs")
```

This will only respond with the "Name" and the "FileAs" fields of the found account.

## Notes:

This API client is largely a work in progress, this project was started with the need of a refactor for an internal project. Many endpoints are not supported and even particular fields of endpoints are not supported. Please feel free to make a pull request with any functionality you may need for your project. My hope is that we can consistenly add more and better functionality to the project as time goes on. Please ensure to look over the code base for supported endpoints, fields and additional documentation.

## Standard Operations

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/finfolio. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

