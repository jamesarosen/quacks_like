## QuacksLike

QuacksLike is a tiny gem intended to push people towards using duck typing instead of static typing.

## Usage

    def some_method(an_argument)
      case an_argument
      when quacks_like?(:to_i)                 # responds_to?(:to_i)
        do_something_with an_argument.to_i
      when quacks_like?(:foo, :bar)            # responds_to?(:foo) && responds_to?(:bar)
        an_argument.foo + an_argument.bar
      else
        raise "#{an_argument} can't quack properly; is it duck-like?"
      end
    end
    
## Getting it

First, of course, install the gem:

    sudo gem install gcnovus-quacks_like
    
Then add it to either the global namespace:

    require 'rubygems'
    require 'gcnovus-quacks_like'
    QuacksLike.install_everywhere!
    
or just use it in one class:

    require 'rubygems'
    require 'gcnovus-quacks_like'
    
    class MyClass
      include QuacksLike
    end