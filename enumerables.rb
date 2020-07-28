# Our enumerable methods
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/PerceivedComplexity
module Enumerable
  def my_each
    arr_default = self
    return arr_default.to_enum unless block_given?

    arr_converted = arr_default.is_a?(Array) ? arr_default : arr_default.to_a
    arr_converted.length.times { |i| yield(arr_converted[i]) }
    return arr_default unless arr_default.is_a?(Array)

    arr_converted
  end

  def my_each_with_index
    arr_default = self
    return arr_default.to_enum unless block_given?

    arr_converted = arr_default.is_a?(Array) ? arr_default : arr_default.to_a
    arr_converted.length.times { |i| yield(arr_converted[i], i) }
    return arr_default unless arr_default.is_a?(Array)

    arr_converted
  end

  def my_select
    arr = self
    return arr.to_enum unless block_given?

    new_arr = []
    arr = arr.is_a?(Array) ? arr : arr.to_a
    arr.my_each { |condition| new_arr.push(condition) if yield(condition) }
    new_arr
  end

  def my_all?(argument = nil)
    arr = self
    arr = arr.is_a?(Array) ? arr : arr.to_a
    all_true = true
    if !argument.nil?
      if argument.is_a?(Regexp)
        arr.my_each { |current_element| all_true = argument.match(current_element) ? all_true : false }
      elsif argument.class == Class
        arr.my_each { |current_element| all_true = current_element.is_a?(argument) ? all_true : false }
      else
        arr.my_each { |current_element| all_true = current_element == argument ? all_true : false }
      end
    elsif block_given? && argument.nil?
      arr.my_each { |condition| all_true = yield(condition) ? all_true : false }
    elsif !block_given? && argument.nil?
      arr.my_each { |current_element| all_true = current_element ? all_true : false }
    end
    all_true
  end

  def my_any?(argument = nil)
    arr = self
    arr = arr.is_a?(Array) ? arr : arr.to_a
    all_true = false
    if !argument.nil?
      if argument.is_a?(Regexp)
        arr.my_each { |current_element| all_true = argument.match(current_element) ? true : all_true }
      elsif argument.class == Class
        arr.my_each { |current_element| all_true = current_element.is_a?(argument) ? true : all_true }
      else
        arr.my_each { |current_element| all_true = current_element == argument ? true : all_true }
      end
    elsif block_given? && argument.nil?
      arr.my_each { |condition| all_true = yield(condition) || all_true }
      all_true
    elsif !block_given? && argument.nil?
      arr.my_each { |current_element| all_true = current_element ? true : all_true }
    end
    all_true
  end

  def my_none?(argument = nil)
    arr = self
    arr = arr.is_a?(Array) ? arr : arr.to_a
    all_true = true
    if !argument.nil?
      if argument.is_a?(Regexp)
        arr.my_each { |current_element| all_true = argument.match(current_element) ? false : all_true }
      elsif argument.class == Class
        arr.my_each { |current_element| all_true = current_element.is_a?(argument) ? false : all_true }
      else
        arr.my_each { |current_element| all_true = current_element == argument ? false : all_true }
      end
    elsif block_given? && argument.nil?
      arr.my_each { |condition| all_true = yield(condition) ? false : all_true }
    elsif !block_given? && argument.nil?
      arr.my_each { |current_element| all_true = current_element ? false : all_true }
    end
    all_true
  end

  def my_count(argument = nil)
    counter = 0
    arr = self
    if argument.nil?
      if block_given?
        arr.my_each { |current_element| counter += 1 if yield(current_element) }
      else
        arr.my_each { counter += 1 }
      end
    else
      arr.my_each { |current_element| counter += 1 if current_element == argument }
    end
    counter
  end

  def my_inject(num = nil, symb = nil)
    arr = self
    arr = arr.is_a?(Array) ? arr : arr.to_a
    return raise LocalJumpError, 'no block given' if !block_given? and num.nil? and symb.nil?

    if num.nil? and symb.nil?
      accumulator = arr[0]
      if block_given?
        (arr.length - 1).times do |i|
          accumulator = yield(accumulator, arr[i + 1])
        end
      end
      accumulator
    elsif num and symb
      unless block_given?
        accumulator = num
        arr.length.times { |i| accumulator = accumulator.send(symb, arr[i]) }
        accumulator
      end
    elsif num.nil? or symb.nil?
      if num.is_a?(Symbol)
        unless block_given?
          accumulator = arr[0]
          symbol = num
          (arr.length - 1).times do |i|
            accumulator = accumulator.send(symbol, arr[i + 1])
          end
          accumulator
        end
      elsif num.is_a?(Integer)
        if block_given?
          accumulator = num
          arr.length.times do |i|
            accumulator = yield(accumulator, arr[i])
          end
          accumulator
        end
      end
    end
  end

  def my_map(passed_proc = nil)
    arr = self
    arr = arr.is_a?(Array) ? arr : arr.to_a
    new_array = []
    if passed_proc.nil?
      return arr.to_enum unless block_given?

      arr.my_each { |current_element| new_array.push(yield(current_element)) }
    else
      arr.my_each { |current_element| new_array.push(passed_proc.call(current_element)) }
    end
    new_array
  end
end

def multiply_els(argument = nil)
  return to_enum unless argument

  if argument.is_a? Array
    argument.my_inject(:*)
  else
    puts 'Pass an array'
  end
end
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity
