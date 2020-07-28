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
  let(:my_hash_block){ proc {|key, value| value > 20 } }
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
    it 'when range and block given' do
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
    let(:range_with_block){ my_range.my_select(&my_array_block) == my_range.select(&my_array_block) }

    it 'when array and block are given' do
        expect(array_with_block).to eql(true)
    end
    
    it 'when array and no block given' do
        expect(my_array.my_select).to be_kind_of(Enumerator)
    end

    it 'when array and block are given' do
        expect(range_with_block).to eql(true)
    end
    
    it 'when array and no block given' do
        expect(my_range.my_select).to be_kind_of(Enumerator)
    end

  end

  describe '#my_all' do
    let(:array_with_block){ my_array.my_all?(&my_array_block) == my_array.all?(&my_array_block) }
    let(:range_with_block){ my_range.my_all?(&my_array_block) == my_range.all?(&my_array_block) }

      it 'when array and block are given' do
          expect(array_with_block).to eql(true)
      end

      it 'when array given but no block and no argument' do
          expect(my_array.my_all?).to eql(true)
      end

      it 'when array of complex numbers given but no block and no argument' do
          expect(my_complex_numbers.my_all?).to eql(true)
      end

      it 'when array of complex given but no block and argument of Class is given' do
          expect(my_complex_numbers.my_all?(Numeric)).to eql(true)
      end

      it 'when array given but no block but argument given' do
          expect(my_array.my_all?(4)).to eql(false)
      end

      it 'when array given but argument of regex is given' do
          expect(my_words.my_all?(/d/)).to eql(false)
      end

      it 'when array given but argument of Class is given' do
          expect(my_words.my_all?(Numeric)).to eql(false)
      end

      it 'when array given but argument of Class is given' do
          expect(my_array.my_all?(Numeric)).to eql(true)
      end

      it 'when an empty array given' do
          expect([].my_all?).to eql(true)
      end

      it 'when array of nil, true is given but no block' do
          expect([nil, true, 99].my_all?).to eql(false)
      end

  end

  describe '#my_any?' do
    let(:array_with_block){ my_array.my_any?(&my_array_block) == my_array.any?(&my_array_block) }
    let(:range_with_block){ my_range.my_any?(&my_array_block) == my_range.any?(&my_array_block) }

    it 'when array and block are given' do
        expect(array_with_block).to eql(true)
    end

    it 'when array given but no block and no argument' do
        expect(my_array.my_any?).to eql(true)
    end

    it 'when array of complex numbers given but no block and no argument' do
        expect(my_complex_numbers.my_any?).to eql(true)
    end

    it 'when array of complex given but no block and argument of Class is given' do
        expect(my_complex_numbers.my_any?(Numeric)).to eql(true)
    end

    it 'when array given but no block but argument given' do
        expect(my_array.my_any?(4)).to eql(true)
    end

    it 'when array given but argument of regex is given' do
        expect(my_words.my_any?(/d/)).to eql(false)
    end

    it 'when array given but argument of Class is given' do
        expect(my_words.my_any?(Numeric)).to eql(false)
    end

    it 'when array given but argument of Class is given' do
        expect(my_array.my_any?(Numeric)).to eql(true)
    end

    it 'when an empty array given' do
        expect([].my_any?).to eql(false)
    end

    it 'when array of nil, true is given but no block' do
        expect([nil, true, 99].my_any?).to eql(true)
    end
    
  end

  describe '#my_none?' do
    let(:array_with_block){ my_array.my_none?(&my_array_block) == my_array.none?(&my_array_block) }
    let(:range_with_block){ my_range.my_none?(&my_array_block) == my_range.none?(&my_array_block) }

    it 'when array and block are given' do
        expect(array_with_block).to eql(true)
    end

    it 'when array given but no block and no argument' do
        expect(my_array.my_none?).to eql(false)
    end

    it 'when array of complex numbers given but no block and no argument' do
        expect(my_complex_numbers.my_none?).to eql(false)
    end

    it 'when array of complex given but no block and argument of Class is given' do
        expect(my_complex_numbers.my_none?(Numeric)).to eql(false)
    end

    it 'when array given but no block but argument given' do
        expect(my_array.my_none?(4)).to eql(false)
    end

    it 'when array given but argument of regex is given' do
        expect(my_words.my_none?(/d/)).to eql(true)
    end

    it 'when array given but argument of Class is given' do
        expect(my_words.my_none?(Numeric)).to eql(true)
    end

    it 'when array given but argument of Class is given' do
        expect(my_array.my_none?(Numeric)).to eql(false)
    end

    it 'when an empty array given' do
        expect([].my_none?).to eql(true)
    end

    it 'when array of nil, true is given but no block' do
        expect([nil, true, 99].my_none?).to eql(false)
    end
  end

  describe '#my_count' do
    let(:array_with_block){ my_array.my_count(&my_array_block) == my_array.count(&my_array_block) }
    let(:range_with_block){ my_range.my_count(&my_array_block) == my_range.count(&my_array_block) }

    it 'when no block and no argument' do
      expect(array_with_block).to eql(true)
    end

    it "when it's a range" do
      expect(range_with_block).to eql(true)
    end

    it 'when there is an argument' do
      expect(my_words.my_count("ruby")).to eql(1)
    end

    it 'when there is a block' do
      expect(my_array.my_count).to eql(TEST_ARRAY_SIZE)
    end

  end

  describe '#my_inject' do
    let(:array_with_block){ my_array.my_inject(&my_array_block) == my_array.inject(&my_array_block) }
    let(:range_with_block){ my_range.my_inject(&my_array_block) == my_range.inject(&my_array_block) }

    it 'when no block and no argument' do
      expect(array_with_block).to eql(true)
    end

    it "when it's a range" do
      expect(range_with_block).to eql(true)
    end

    
  end

end
