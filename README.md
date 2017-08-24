# FlexStruct

A drop-in replacement for Struct which adds a more flexible initialize method

## Usage

### Basic

Create a `FlexStruct` very similarly to how you'd use any other `Struct`:

    Pet = FlexStruct.new(:species, :name, :colour)

However, `FlexStruct`-created classes can be initialized in more readable ways than
default `Struct`s:

    # Your only option with a Struct, positional arguments that require you to
    # know which order the parameters were defined
    floppy = Pet.new(:rabbit, "Floppy", :brown)

    # Use hash/keyword arguments
    fido = Pet.new(name: "Fido", species: :dog)

    # Use block initialization
    marmaduke = Pet.new do |pet|
      pet.name = "Marmaduke"
      pet.species = :cat
      pet.colour = :tortoiseshell
    end

### Customisation

`FlexStruct` acts just like a `Struct` in other ways, you can customize its
behaviour and add functionality to the generated class by passing a block to the
`FlexStruct` constructor:

    Person = FlexStruct.new(:forename, :surname) do
      def fullname
        [forename, surname].compact.join(" ")
      end
    end

    Person.new(forename: "Finn", surname: "Mertens").fullname
    # => "Finn Mertens"

It's possible to overwrite the `initialize` method this way - so be sure to use
`super` if you do this. Or better, don't do this, you probably don't need to.

### Immutability

`FlexStruct` comes with a convenience method for making immutable `Struct`s. This
will amend the generated struct to make it frozen after initialization:

    Position = FlexStruct.new(:lat, :lng) { prepend FlexStruct::Frozen }

    location = Position.new(lat: 44.681, lng: 169.101)
    location.lat = -70.850
    # => RuntimeError: can't modify frozen Position

## Why?

`Hash`es are great. You can use them to store arbitrary key/value pairs using
any object as a key (although commonly people use `Symbol`s).

However, `Hash`es are (by design) quite limited. Data is accessed using a small
subset of method calls, so if you're passing data around your Ruby program in a
`Hash`, every method using that data needs to know it's in a `Hash`(like) object.

`OpenStruct`s are great. They behave a lot like a `Hash` that only has `Symbol`
keys - you can set arbitrary values against any named property. You also get to
get and set those values using regular Ruby methods, which means an `OpenStruct`
can be often used as a substitute for any other Ruby object, thanks to duck
typing. And to show how like-a-`Hash` it is, you can pass a `Hash` into its
initializer and have all of the corresponding properties set.

However, an `OpenStruct` will (by design) cheerfully respond `nil` to any
property it doesn't explicitly know about, and let you set values for any
property you like. While this is good in a lot of cases, you sometimes want
data structures that (like most Ruby objects) have a fixed API. `OpenStruct`
also has performance issues if you're going to create large numbers of them.

`Struct`s are great. They're the most lightweight way to create a class with
fixed attributes - you can create a data structure without having to worry about
a lot of the `nil` issues that can crop up with the dynamic structures above.

However, once you've created a `Struct` class, the initialize method can only be
called using positional arguments - to initialize a `Struct` class with data, you
need to know the order its properties were initialized with. That's not
convenient or readable.

## Yes, but why?

`Struct`s are really useful classes that often make more sense than `Hash`es or
`OpenStruct`s for a lot of their common use cases. But their inflexible
initializers make them a pain to use.

It's really easy to extend a Ruby `Struct` with new methods, including a better
initializer, but the amount of boilerplate required turns what would otherwise
be a one-liner class definition into a much heavier ugly addition.

`FlexStruct` just creates regular `Struct`-based classes with this smarter
initializer. The entire useful code of this gem is 14 lines, significantly
smaller than even this section of the README!

But to get people using data structures that are more useful, descriptive, and
lightweight, it should be as easy as possible to create them. Hence:
`FlexStruct`!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'flex_struct'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flex_struct

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/bridgeu/flex_struct. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FlexStruct project’s codebases, issue trackers, chat
rooms and mailing lists is expected to follow the [code of
conduct](https://github.com/bridgeu/flex_struct/blob/master/CODE_OF_CONDUCT.md).
