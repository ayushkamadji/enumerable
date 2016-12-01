module Enumerable
  def my_each
    return enum_for(__method__) unless block_given?
    for i in (0... self.to_a.length)
      yield(self.to_a[i])
    end
    return self
  end

  def my_each_with_index(&proc)
    return enum_for(__method__) unless block_given?
    for i in (0... self.to_a.length)
      yield(self.to_a[i],i)
    end 
    return self
  end

  def my_select(&p)
    return enum_for(__method__) unless block_given?
    selection = []
    self.my_each{|x| selection << x if p.call(x)}
    return selection
  end 

  def my_all?
    return self.my_all? {|x| x} unless block_given?
    result = true
    self.my_each {|x| result = yield(x) && result}
    return result ? true : false
  end

  def my_any?
    return self.my_any? {|x| x} unless block_given?
    result = false
    self.my_each {|x| result = yield(x) || result}
    return result ? true : false
  end

  def my_none?(&p)
    return !self.my_any?(block_given? ? (p) : ())
  end

  def my_count(*args,&p)
    raise ArgumentError.new("wrong number of arguments (given #{args.length}, expected 1)") if args.length > 1
    unless block_given?
      return self.my_count {|x| x == args[0]} if args.length > 0
      return self.my_count {|x| true}
    end
    count = 0
    self.my_each {|x| count += 1 if p.call(x)}
    return count
  end

  def my_map
    return enum_for(__method__) unless block_given?
    result = []
    self.my_each {|x| result << yield(x)}
    return result
  end
end
