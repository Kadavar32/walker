# StructureWalker

[![Build Status](https://travis-ci.org/Kadavar32/walker.svg?branch=master)](https://travis-ci.org/Kadavar32/walker)

Deep nested structure walker.

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

Examples:

      handler = ->(data) { data[:example_key] = 'some_value'; data }

      data = { some_key: { specific_key: [{ key: 'value' }, { key: 'value' }], another_key: {key: 'value' } } }  

      steps = [[:enum, :hash], [:key, :specific_key], [:enum, :array]]

      walker = StructureWalker::Builder.invoke(handler)

      result = walker.call(steps, data)

      result # => { some_key: { specific_key: [{ key: "value", example_key: "some_value" }, { key: "value", example_key: "some_value" }], another_key: { key: "value" } } }

Example with multiple keys:

     handler = ->(data) { data[:example_key] = 'some_value'; data }

     data = { key: { specific_key: [{ key: 'value' }], another_key:  [{ key: 'value' }], one_more_key: [{ key: 'value' }] } }

     steps = [[:enum, :hash], [:keys, [:specific_key, :one_more_key]], [:enum, :array]]

     walker = StructureWalker::Builder.invoke(handler)

     result = walker.call(steps, data)

     result # => { key: { specific_key: [{ key: 'value', new_key: 'value' }], another_key:  [{ key: 'value' }], one_more_key: [{ key: 'value', new_key: 'value' }]} }
 
Available steps:
    
        [:enum, :hash]
        [:enum, :array]
        [:key, :some_key]
        [:keys, [:key_one, :key_two]]
        [:method, :method_name]


## Contributing
    Fork it
    Create your feature branch (git checkout -b my-new-feature)
    Commit your changes (git commit -am 'Add some feature')
    Push to the branch (git push origin my-new-feature)
    Create new Pull Request


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
