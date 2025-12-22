#!/usr/bin/env ruby
# frozen_string_literal: true

def part1(input)
  ranges, ingredients = input.split("\n\n").map { _1.lines.map(&:chomp) }

  ingredients.select do |ingredient|
    ranges.any? do |range|
      floor, ceil = range.split('-').map(&:to_i)
      (floor..ceil).include?(ingredient.to_i)
    end
  end.length
end

def part2(input)
  # TODO
end

real_input = File.read('day05-input.txt')

puts "Part 1: #{part1(real_input)}"
# answer 577
puts "Part 2: #{part2(real_input)}"
