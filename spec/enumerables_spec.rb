require('../enumerables')

TEST_ARRAY_SIZE = 100
MIN_VALUE = 0
MAX_VALUE = 9

describe Enumerable do
  let(:my_array) { Array.new(TEST_ARRAY_SIZE) { rand(MIN_VALUE...MAX_VALUE) } }
  let(:my_array_block) { proc { |current_element| current_element < (MIN_VALUE + MAX_VALUE) / 2 } }
  let(:my_words) { %w[cool ruby rubygems rspec programming software] }
  let(:my_words_block) { proc { |current_element| current_element.length > 9  } }
  let(:my_range) { Range.new(10, 100) }
  let(:my_hash) { { ruby: 12, javascript: 23, java: 33, nodejs: 14, sql: 5, reactjs: 22 } }
  let(:my_complex_numbers) { [3i, 5, 3.14] }

  describe '#my_each' do
    let(:array_with_block) { my_array.my_each(&my_array_block) == my_array.each(&my_array_block) }
    let(:range_with_bloc) { my_range.my_each(&my_array_block) == my_range.each(&my_array_block) }
    it 'when array and block given' do
        expect(array_with_block).to eql(true)
    end
    it 'when array and no block given' do
        expect(my_array.my_each).to be_kind_of(Enumerator)
    end
    it 'when ranche and block given' do
        expect(range_with_bloc).to eql(true)
    end
    it 'when array and no block given' do
        expect(my_range.my_each).to be_kind_of(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    let(:array_with_block) { my_array.my_each_with_index(&my_array_block) == my_array.each(&my_array_block) }
    let(:range_with_block) { my_range.my_each_with_index(&my_array_block) == my_range.each(&my_array_block) }
    it 'when array and block given' do
        expect(array_with_block).to eql(true)
    end
    it 'when array and no block given' do
        expect(my_array.my_each_with_index).to be_kind_of(Enumerator)
    end
    it 'when ranche and block given' do
        expect(range_with_block).to eql(true)
    end
    it 'when array and no block given' do
        expect(my_range.my_each_with_index).to be_kind_of(Enumerator)
    end
  end

  describe '#my_select' do
    let(:array_with_block){ my_words.my_select(&my_words_block) == my_words.select(&my_words_block) }

    it 'when array and block are given' do
        expect(array_with_block).to eql(true)
    end
    
    it 'when array and no block given' do
        expect(my_array.my_select).to be_kind_of(Enumerator)
    end
  end

end