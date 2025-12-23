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

def without_overlaps(ranges)
  sorted_ranges = ranges.sort_by(&:first)

  sorted_ranges.each_with_object([]) do |range, merged|
    if merged.empty? || range.first > merged.last.last
      merged << range
    else
      max = [merged.last.last, range.last].max
      merged[-1] = [merged.last.first, max]
    end
  end
end

def part2(input)
  unparsed_ranges, = input.split("\n\n")

  ranges = unparsed_ranges
           .lines
           .flat_map { _1.lines.map { |line| line.chomp.split('-').map(&:to_i) } }

  without_overlaps(ranges).map { |(floor, ceil)| (floor..ceil) }.sum(&:count)
end

real_input = File.read('day05-input.txt')

puts "Part 1: #{part1(real_input)}"
# answer 577
puts "Part 2: #{part2(real_input)}"
# 432907450074353 too high
# 395635883201578 too high
