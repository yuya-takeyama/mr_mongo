# Mr. Mongo

MapReduce framework for MongoDB using Ruby DSL

## Installation

Add this line to your application's Gemfile:

    gem 'mr_mongo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mr_mongo

## Usage

### mr_mongo command

```
$ bundle exec mr_mongo
Commands:
  mr_mongo exec            # executes MapReduce
  mr_mongo exec_on_memory  # executes MapReduce on memory
  mr_mongo help [COMMAND]  # Describe available commands or one specific command
```

*NOTICE*

The result of exec_on_memory may be massive, so it's preferable to use for small collections as testing.

### Defining MapReduce job using DSL

Following is word-count example using Mr. Mongo DSL

```ruby
set :collection, 'texts'
set :out, {replace: 'word_counts'}

__END__

@@ map
function () {
  this.text.split(/\s+/).forEach(function (word) {
    emit(word, {count: 1});
  });
}

@@ reduce
function (key, values) {
  var count = 0;

  values.forEach(function (value) {
    count += value.count;
  });

  return {count: count};
}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
