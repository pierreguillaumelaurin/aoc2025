#!/usr/bin/env ruby
# frozen_string_literal: true

def part1(input)
  input
    .lines
    .map(&:chomp)
    .map { _1.split(/\s+/) }
    .transpose
    .map { |*numbers, operator| [numbers.map(&:to_i), operator] }
    .sum { |numbers, operator| operator == '+' ? numbers.sum : numbers.reduce(1) { |n, product| product * n } }
end

def part2(input)
  # TODO
end

real_input = File.read('day06-input.txt')

puts "Part 1: #{part1(real_input)}"
# answer 3261038365331
puts "Part 2: #{part2(real_input)}"
