# == QuacksLike
#
# QuacksLike is a tiny gem intended to push people towards using
# duck typing instead of static typing.
#
# == Usage
#
#   def some_method(an_argument)
#     case an_argument
#     when quacks_like?(:to_i)                 # responds_to?(:to_i)
#       do_something_with an_argument.to_i
#     when quacks_like?(:foo, :bar)            # responds_to?(:foo) && responds_to?(:bar)
#       an_argument.foo + an_argument.bar
#     else
#       raise "#{an_argument} can't quack properly; is it duck-like?"
#     end
#   end
#
# == Installation
#
# === Riding the Rails
#
# Add the following to your <tt>environment.rb</tt>:
#
#   config.gem 'gcnovus-quacks_like', :version => '~> 1.0.0', :lib => 'quacks_like', 
#    :source => 'http://gems.github.com'
#
# === Anywhere else
#
# From your command prompt:
#
#   sudo gem install gcnovus-quacks_like
#
# == Setting it up
# 
# === Globally
#
# If you don't mind mucking with Kernel and want the easiest thing
# that could possibly work, do this:
#
#   require 'rubygems'
#   require 'gcnovus-quacks_like'
#   QuacksLike.install_everywhere!
#
# === Or just for one class
#
#   require 'rubygems'
#   require 'gcnovus-quacks_like'
#   
#   class MyClass
#     include QuacksLike    # for instance methods
#     extend  QuacksLike    # for class methods
#   end
module QuacksLike
  
  def self.install_everywhere!
    Kernel.class_eval do
      include ::QuacksLike
    end
  end
  
  # Create a new matcher that matches all of the methods given.
  #
  # Raises a <tt>NoMethodError</tt> if any method does not respond
  # to <tt>:to_sym</tt>.
  #
  # Raises a <tt>ArgumentError</tt> if any method responds to
  # <tt>:to_sym</tt> but the result is not a <tt>Symbol</tt>.
  def quacks_like?(*methods)
    ::QuacksLike::Matcher.new(*methods)
  end
  
  class Matcher
    
    def initialize(*methods)
      @methods = methods.map do |m|
        sym = m.to_sym
        raise ArgumentError.new("#{m} could not be converted to a symbol") unless sym
        sym
      end
    end
    
    # Returns +true+ iff +object+ responds to all of <tt>self</tt>'s methods.
    def ===(object)
      @methods.all? { |m| object.respond_to?(m) }
    end
    
  end
  
end