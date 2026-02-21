#!/usr/bin/env ruby
# frozen_string_literal: true

def area((x1, y1), (x2, y2))
  ((x1 - x2).abs + 1) * ((y1 - y2).abs + 1)
end

def part1(input)
  red_tiles = input.lines.map(&:chomp).map { _1.split(',').map(&:to_i) }
  distances = (0...red_tiles.length).each_with_index.with_object([]) do |(_, first_idx), acc|
    (0...first_idx).each do |second_idx|
      acc << area(red_tiles[first_idx], red_tiles[second_idx])
    end
  end

  distances.max
end

def part2(input)
  # TODO
end

real_input = File.read('day09-input.txt')

puts "Part 1: #{part1(real_input)}"
# answer 4749838800
puts "Part 2: #{part2(real_input)}"
