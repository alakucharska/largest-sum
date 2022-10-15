class LargestSum

  def initialize(array_of_numbers)
    @array_of_numbers = array_of_numbers
  end

  attr_reader :array_of_numbers

  def biggest_number_after_changes
    return array_of_numbers if all_digits_9?

    final_result = []
    if number_of_remaining_changes == 3 || number_of_remaining_changes == 6
      hash = { biggest_number_possible => number_of_remaining_changes } 
      hash.each do |biggest_number, remaining_changes|
        final_result << add_number_of_changes_to_the_number(biggest_number, remaining_changes)
      end
      index_of_the_number_to_be_replaced = numbers_divisible_by_3.index(biggest_number_possible)
      numbers_divisible_by_3[index_of_the_number_to_be_replaced] = final_result[0]
      numbers_divisible_by_3
    else
      numbers_divisible_by_3 
    end
  end

  private

  def all_digits_9?
    array_of_numbers.map do |number|
      return false if number.abs.digits.any? { |value| value != 9 }
    end
  end
    
  def changes_needed_to_get_numbers_divisible_by_3
    modulo_result = array_of_numbers.map{ |number| number%3 } 
    modulo_result.map do |value| 
      value != 0 ? 3 - value : 0  
    end
  end

  def assign_changes_to_numbers
    Hash[ array_of_numbers.zip(changes_needed_to_get_numbers_divisible_by_3) ] 
  end

  def position_of_digit_to_change(number) 
    position = 0
    number.abs.digits.reverse.map do |digit|
      break if digit != 9 || number.digits.all? {|value| value == 9}
      position += 1 
    end
    position
  end

  def add_number_of_changes_to_the_number(number, changes) 
    power = number.abs.digits.count - position_of_digit_to_change(number)
    number + (changes*(10**(power-1)))
  end

  def change_numbers_to_be_the_biggest_divisible_by_3
    array_of_numbers_divisible_by_3 = []
      assign_changes_to_numbers.each do |number, changes| 
        array_of_numbers_divisible_by_3 << add_number_of_changes_to_the_number(number, changes)
      end
    array_of_numbers_divisible_by_3              
  end

  def numbers_divisible_by_3
    @divisors_of_3 ||= change_numbers_to_be_the_biggest_divisible_by_3
  end

  def biggest_number_possible
    numbers_divisible_by_3.sort.reverse.find do |element| 
      !element.abs.digits.all? { |value| value == 9 }
    end
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
array_of_numbers = gets.chomp.split(/[\s.,]+/).map(&:to_i)

LargestSum.new(array_of_numbers).biggest_number_after_changes  
