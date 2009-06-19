$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'test/unit'
require 'rubygems'
require 'shoulda'
require 'mocha'
require 'quacks_like'

class Duck
  def eat(bread)
    "yum"
  end
  def quack!
    "quack!!"
  end
end

class QuacksLikeTest < Test::Unit::TestCase
  
  context 'the QuacksLike class' do
    setup { Kernel.expects(:include).with(QuacksLike) }
    should 'be able to install itself everywhere' do
      QuacksLike.install_everywhere!
    end
  end
  
  context ':quacks_like?' do
    
    setup do
      extend QuacksLike
    end
    
    context 'given an argument that cannot be converted to a Symbol' do
      should 'raise an NoMethodError' do
        assert_raises(NoMethodError) { quacks_like?(Object.new) }
      end
    end
    
    context 'given an argument that knows how to convert to a Symbol, but can\'t' do
      should 'raise an ArgumentException' do
        assert_raises(ArgumentError) { quacks_like?(8) }
      end
    end
    
    context 'given a single valid argument' do
      
      should 'return a Object that acts as a matcher' do
        matcher = quacks_like?(:foo)
        assert !matcher.nil?
        assert matcher.respond_to?(:===)
      end
      
      should 'create a matcher that checks that arguments respond to the given method' do
        assert   quacks_like?(:eat) === Duck.new
        assert !(quacks_like?(:juggle) === Duck.new)
      end
      
    end
    
    context 'given several valid arguments' do
      
      should 'create a matcher that checks that arguments respond to ALL of the given methods' do
        assert   quacks_like?(:eat, :quack!, :to_s) === Duck.new
        assert !(quacks_like?(:eat, :juggle, :to_s) === Duck.new)
      end
        
    end
    
  end
  
end
