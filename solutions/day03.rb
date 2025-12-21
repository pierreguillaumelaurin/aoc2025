#!/usr/bin/env ruby
# frozen_string_literal: true

def maxes(nums, left)
  return nums.max if left == 1

  next_left = left - 1
  first, i = nums[0...nums.length - (left - 1)].each_with_index.max { |a, b| a[0] <=> b[0] }
  rest = nums[(i + 1)..nums.length]

  first * (10**(left - 1)) + maxes(rest, left - 1)
end

def part1(input)
  input
    .lines
    .map(&:chomp)
    .map { |line| line.chars.map(&:to_i) }
    .map { |line| maxes(line, 2) }
    .sum
end

def part2(input)
  input
    .lines
    .map(&:chomp)
    .map { |line| line.chars.map(&:to_i) }
    .map { |line| maxes(line, 12) }
    .sum
end

real_input = File.read('day03-input.txt')

puts "Part 1: #{part1(real_input)}"
puts "Part 2: #{part2(real_input)}"
raise "wrong answer #{part1(real_input)}" unless part1(real_input) == 17_155

puts maxes('987654321111111'.chars.map(&:to_i), 2)
puts maxes('811111111111119'.chars.map(&:to_i), 2)
puts maxes('234234234234278'.chars.map(&:to_i), 2)
puts maxes('818181911112111'.chars.map(&:to_i), 2)
puts maxes('111111111111110'.chars.map(&:to_i), 2)
