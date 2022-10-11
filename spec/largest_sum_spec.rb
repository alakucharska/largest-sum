require_relative "../largest_sum"

RSpec.describe LargestSum do

  it "adds remaining changes to the biggest number in the array" do
    num = [2,3,4]

    expect(LargestSum.new(num).biggest_number_after_changes).to eq([3,3,9])
  end

  it "adds 3 to the firts digit in a number if number of changes is >=3 and <6" do
    num = [12,14,17]

    expect(LargestSum.new(num).biggest_number_after_changes).to eq([12,24,57])
  end

  it "does not make any changes to numbers if number of changes is <3" do
    num = [10,14,5]

    expect(LargestSum.new(num).biggest_number_after_changes).to eq([30,24,6])
  end

  xit "returns the same number of elements as in the original array" do
    num = [3,3,6]

    expect(LargestSum.new(num).biggest_number_after_changes).to eq([3,3,12])
  end

  it "accepts negative numbers" do
    num = [-13, -14, -15]

    expect(LargestSum.new(num).biggest_number_after_changes).to eq([-3,9,-15])
  end

  it "accepts negative and positive numbers in one array" do
    num = [-2006, 5, 99]

    expect(LargestSum.new(num).biggest_number_after_changes).to eq([-6,6,129])
  end
end
