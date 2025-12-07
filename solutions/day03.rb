#!/usr/bin/env ruby
# frozen_string_literal: true

def maxes(nums)
  first, i = nums[0...nums.length - 1].each_with_index.max{|a,b| a[0] <=> b[0]}
  second = nums[i + 1..nums.length - 1].max

  first * 10 + second
end

def part1(input)
  input
    .lines
    .map(&:chomp)
    .map{|line| line.chars.map(&:to_i)}
    .map{|line| maxes(line)}
    .sum
end

def part2(input)
  # TODO
end

real_input = File.read('day03-input.txt')

puts "Part 1: #{part1(real_input)}"
puts "Part 2: #{part2(real_input)}"
puts maxes("987654321111111".chars.map(&:to_i))
puts maxes("811111111111119".chars.map(&:to_i))
puts maxes("234234234234278".chars.map(&:to_i))
puts maxes("818181911112111".chars.map(&:to_i))
puts maxes("111111111111110".chars.map(&:to_i))
