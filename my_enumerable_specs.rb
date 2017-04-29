require_relative 'my_enumerable'

describe Enumerable do

	let (:ary) { [1,2,3,4,5] }
	let (:result) { [] }

	describe '#my_each' do

		it 'yields each element of array' do
			ary.my_each { |i| result << i }
			expect(result).to eql(ary)
		end
	end

	describe '#my_each_with_index' do

		it 'yields each element of array and yields index number' do
			a = b = nil
			[1,2,3].my_each_with_index { |x, y| a, b = x, y }
			expect(a).to eql(3)
			expect(b).to eql(2)
		end

		it 'sums the number with its index' do
			a = nil
			ary.my_each_with_index { |x, y| a = x + y }
			expect(a).to eql(9)
		end
	end

	describe '#my_select' do
		
		it 'returns elems of array if block true' do
			a = ary.my_select { |i| i > 3 }
			expect(a).to eql([4, 5])
		end
	end

	describe '#my_count' do

		it 'counts number of elements if no block given' do
			expect([].my_count).to eql(0)
			expect([1].my_count).to eql(1)
			expect(ary.my_count).to eql(5)
		end

		it 'counts elements matching arg if arg given' do
			expect([1,2,3,3,4,5].my_count(3)).to eql(2)
			expect([9,10,11,12].my_count(5)).to eql(0)
		end

		it 'counts the elements yielding a true value if block given' do
			a = ary.my_count { |i| i < 3 }
			expect(a).to eql(2)
		end
	end

	describe '#map' do

		it 'returns array with results of running block' do
			a = ary.my_map { |i| i * i }
			expect(a).to eql([1, 4, 9, 16, 25])

			a = ary.my_map { "ape" }
			expect(a).to eql(['ape', 'ape', 'ape', 'ape', 'ape'])
		end
	end

	describe '#my_inject' do

		it 'sums some numbers using arg' do
			a = ary.my_inject(:+)
			expect(a).to eql(15)
		end

		it 'sums some numbers using block' do
			a = ary.my_inject { |sum, n| sum + n }
			expect(a).to eql(15)
		end

		it 'multiplies some numbers using arg' do
			a = ary.my_inject(:*)
			expect(a).to eql(120)
		end

		it 'multiplies some numbers using block' do
			a = ary.my_inject { |product, n| product * n }
			expect(a).to eql(120)
		end

		it 'finds the longest word' do
			longest = %w{ cat sheep bear }.my_inject do |memo,word|
   			memo.length > word.length ? memo : word
   		end
   		expect(longest).to eql('sheep')
   	end
	end
end