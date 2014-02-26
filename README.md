# Debugfile

Debugfile stores temporary file for debugging, based on ruby/mri/lib/tempfile.rb

You can store files in your tmporary directory orderd by date. For example, when you file uploader fails to complete uploading process, you can get the file for debug.

## Installation

Add this line to your application's Gemfile:

    gem 'debugfile'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install debugfile

## Usage


== Synopsis

```ruby
  require 'debugfile'

  file = Debugfile.new('for_debug', 'foo.txt')
  file.path #=> e.g.: "/tmp/for_debug/20140226/e34d7899-09cf-4b46-8ef4-4f751f9ae649-foo.txt"
  file.write "hello!"
  file.rewind
  file.read  #=> "hello!"
  file.close

  file = Debugfile.open('for_debug', 'foo.txt') {|f| f.write "Ruby!" }
  file.open
  file.read #=> "Ruby!"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
