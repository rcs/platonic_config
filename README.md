# Platonic Config
A mixin to allow easy class and instance level configuration, with easy
defaults.

## Installation

```shell
gem install platonic_config
```

## Example Usage

```ruby
require 'platonic_config'
class MyAwesomeShirt
  include PlatonicConfig
  define_options :color => 'red', :size => 'large', :logo => nil
end

MyAwesomeShirt.color # => 'red'
MyAwesomeShirt.color 'blue'
MyAwesomeShirt.color # => 'blue'

MyAwesomeShirt.config do |c|
  c.size 'large'
end

MyAwesomeShirt.size # => 'large'

shirt = MyAwesomeShirt.new

shirt.config do |c|
  c.logo 'Batman'
  c.size 'medium'
end

shirt.logo # => 'Batman'
shirt.options # => { :color => 'red', :size => 'medium', :logo => 'Batman' }

MyAwesomeShirt.reset_defaults
MyAwesomeShirt.options # => :color => 'red', :size => 'large', :logo => nil
another_shirt = MyAwesomeShirt.new
another_shirt.options # => :color => 'red', :size => 'large', :logo => nil
```

## Usage

To start using PlatonicConfig, include the module in your class, and set
the default configuration values.

```ruby
class C
  include PlatonicConfig
  define_options :opt1 => 'foo', :opt2 => 'bar'
end
```

### On the class

From this point on, your class will respond to all these configuration
options, and be able to be configured using a block.

```ruby
C.config do |c|
  c.opt1 'spam'
end
```

Any individual option can be queried with the option name, or all
options can be looked at with "options".

```ruby
C.opt1    # => 'spam'
C.options # => { :opt1 => 'foo', :opt2 => 'bar' }
```

To reset configuration to the defaults you specified, call
reset_defaults.

```ruby
C.reset_defaults
```


### On the instance

Any new instances of your class can be configured independently

```ruby
instance = C.new
instance.config do |c|
  c.opt2 'bananas'
end
```

All options are merged with the options set in the class, with the
instance variables overriding. Any of these options can be queried
individually, or examined all at once.

```ruby
instance.opt2 # => 'bananas'
instance.options # => { :opt1 => 'foo', :opt2 => 'bananas' }
```

To clear the options set on the instance (and letting the class defaults
come through), call reset_defaults.

```ruby
instance.reset_defaults
```



