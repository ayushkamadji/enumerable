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

  #def my_map
  #  return enum_for(__method__) unless block_given?
  #  result = []
  #  self.my_each {|x| result << yield(x)}
  #  return result
  #end
  
  def my_map(*p)
    result = []
    unless (p.length == 1 && (p.first.is_a? Proc))
      raise ArgumentError unless p.length == 0
      return enum_for(__method__) unless block_given?
      self.my_each {|x| result << yield(x)}
      return result
    end
    self.my_each {|x| result << p.first.call(x)}
    return result
  end

  def my_inject(*args)
    raise ArgumentError.new("wrong number of arguments (given #{args.length}, expected 0..2)") if args.length > 2
    memo = nil
    case args.length
      when 0 then self.my_each_with_index {|x,i| i == 0 ? memo = x : memo = yield(memo,x) }
      when 1
            return self.my_inject {|x,y| x.send(args[0],y)} unless block_given?
            memo = args[0]
            self.my_each {|x| memo = yield(memo,x)}
      when 2 then return self.my_inject(args[0]) {|x,y| x.send(args[1],y)}
    end
    return memo 
  end
end

def multiply_els(arr)
  arr.my_inject(:*)
end
