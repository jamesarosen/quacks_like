module QuacksLike
  
  def self.install_everywhere!
    Kernel.class_eval do
      include ::QuacksLike
    end
  end
  
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
    
    def ===(object)
      @methods.all? { |m| object.respond_to?(m) }
    end
    
  end
  
end