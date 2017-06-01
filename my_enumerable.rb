module Enumerable

  def my_each
  	i = 0
  	self.length.times do
			yield(self[i])
			i += 1
  	end
  	self
	end

	def my_each_with_index
    self.length.times do |i|
      x = self[i]
	    yield(x, i)
    end
	end

	def my_select
	  selected = []
		self.my_each { |i| if yield(i) == true then selected << i end }
		selected
	end

	def my_all?
		truth_value = []
		self.my_each { |i| truth_value << yield(i) }
		truth_value.include? false ? false : true
	end

	def my_any?
		truth_value = []
		self.my_each { |i| truth_value << yield(i) }
		truth_value.include? true ? true : false
	end

	def my_none?
		truth_value = []
		self.my_each { |i| truth_value << yield(i) }
		truth_value.include? true ? false : true
	end

  
  def my_count(*arg)
    container = self
    if arg.length != 0
      container = container.my_select { |i| i == arg.join.to_i }
    end
    if block_given?
      container = container.my_select { |i| yield(i) == true }
    end
    container.length
  end

	def my_map
		result = []
		self.my_each do |i|
		  if block_given?
		    result << yield(i)
		  else
			  result << my_proc.call(i)
			end
		end
		result
	end

	def my_inject(*arg)
	  if block_given?
	    memo = self[0]
	    self.my_each_with_index do |elem, i|
	      if i == 0
	        next if elem == memo
	      else
	        memo = yield(memo, elem)
	      end
	    end
	  elsif arg.length == 1
	    memo = 0
	    case arg.join
	    when '+'
	      self.my_each { |i| memo += i }
	    when '-'
	      memo = self[0]
	      container = self
	      container.shift
	      container.my_each { |i| memo -= i }
	    when '*'
	      memo = 1     
	      self.my_each { |i| memo *= i }
	    when '/'
	      self.my_each { |i| memo /= i }
	    else
	      raise NoMethodError
	    end
	  end
	  memo
	end

	#example:
	print [1,2,3,4,5].inject(:*)
end

def multiply_els(arg) 
	arg.my_inject(1) { |memo, n| memo * n }
end

my_proc = Proc.new { |i| i += 1 }

[1,2,3,4,5].my_map(&my_proc)