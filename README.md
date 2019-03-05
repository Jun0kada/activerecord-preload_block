# Activerecord::PreloadBlock
[![Build Status](https://travis-ci.org/Jun0kada/activerecord-preload_block.svg?branch=master)](https://travis-ci.org/Jun0kada/activerecord-preload_block)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord-preload_block'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord-preload_block

## Usage

```ruby
# eq: User.all.preload(:comments, :posts)
User.all.preload do |records|
  preload records, :comments
  preload records, :posts
end

# filter preload owner
User.all.preload do |records|
  preload records.select(&:hoge?), :comments
end

# filter preload associations records
User.all.preload do |records|
  preload records, :comments, Comment.where(hoge: 'foo')
end

# with arguments
User.all.preload(:posts) do |records|
  preload records, :comments
end
```

[gem 'activerecord-records_on_load'](https://github.com/Jun0kada/activerecord-records_on_load)
is also helpful for customizing AR records loaded hook

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/activerecord-preload_block. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Activerecord::PreloadBlock project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/activerecord-preload_block/blob/master/CODE_OF_CONDUCT.md).
