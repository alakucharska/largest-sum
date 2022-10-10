class LargestSum

  def initialize(num)
    @num = num
  end

  attr_reader :num

  def biggest_number_after_changes
    arr1 = []
    if number_of_remaining_changes == 3 || number_of_remaining_changes == 6
      hash = { numbers_divisible_by_3.max => number_of_remaining_changes }
      hash.each do |k, v|
        power = k.digits.count
        b_num = k + (v*(10**(power-1)))
        arr1 << b_num
      end
      i = numbers_divisible_by_3.index(numbers_divisible_by_3.max)
      numbers_divisible_by_3[i] = arr1[0]
      numbers_divisible_by_3
    else
      numbers_divisible_by_3
    end
  end

  private

  def change_negative_numbers_into_positive
    num.map! do |n|
      n.abs
    end
    num
  end

  def positive_numbers
    @positive_numbers ||= change_negative_numbers_into_positive
  end
    
  def changes_needed_to_get_numbers_divisible_by_3
    result = positive_numbers.map{|n| n%3} 
    result.map do |dif| 
      dif != 0 ? 3-dif : 0
    end
  end

  def assign_changes_to_numbers
    Hash[positive_numbers.zip(changes_needed_to_get_numbers_divisible_by_3)] 
  end

  def change_numbers_to_be_the_biggest_divisible_by_3
    arr = []
    assign_changes_to_numbers.each do |key, value| 
      power = key.digits.count 
      arr << key + (value * (10**(power -1)))
    end
      arr
  end

  def numbers_divisible_by_3
    @numbers ||= change_numbers_to_be_the_biggest_divisible_by_3
  end

  def number_of_remaining_changes
    changes = 6-(changes_needed_to_get_numbers_divisible_by_3).sum 
    if (0...3) === changes
      changes = 0
    elsif (3..5) === changes
      changes = 3
    else
      changes = 6
    end
      changes
  end
end

puts "Please enter 3 numbers"
num = gets.chomp.split(/[\s.,]+/).map(&:to_i)

LargestSum.new(num).biggest_number_after_changes  
