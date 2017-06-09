# StructureWalker

Structure Walker helps walk through nested structures and process what you need and how you want.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'structure_walker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install structure_walker

## Usage

Example:

      handler = ->(data) { data[:example_key] = 'some_value'; data }

      data = { some_key: { specific_key: [ { key: 'value' }, { key: 'value' }], another_key: {key: 'value' } } }

      steps = [[:enum, :hash], [:key, :specific_key], [:enum, :array]]

      walker = StructureWalker::Builder.invoke(handler)

      result = walker.call(steps, data)

      {:some_key=>{:specific_key=>[{:key=>"value", :example_key=>"some_value"}, {:key=>"value", :example_key=>"some_value"}], :another_key=>{:key=>"value"}}}

Available steps:
[:enum, :hash]
[:enum, :array]
[:key, :some_key]
[:method, :method_name]

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/structure_walker.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

