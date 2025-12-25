#!/usr/bin/env ruby
# frozen_string_literal: true

def part1(input)
  grid = input.lines.map(&:chomp).map { _1.split('') }

  beam_positions = Hash.new { |hash, key| hash[key] = Set.new }
  starting_column = grid[0].find_index { _1 == 'S' }
  beam_positions[0].add(starting_column)

  count = 0

  (1..grid.length - 1).each_with_object(beam_positions) do |row_index, beam_positions|
    grid[row_index].each_with_index do |cell, i|
      has_beam_above = beam_positions[row_index - 1].include?(i)
      if cell == '^' && has_beam_above
        beam_positions[row_index].add(i - 1) if i - 1 >= 0 && i - 1 < grid[row_index].length
        beam_positions[row_index].add(i + 1) if i + 1 >= 0 && i + 1 < grid[row_index].length
        count += 1
      elsif has_beam_above
        beam_positions[row_index].add(i) if i >= 0 && i < grid[row_index].length
      end
    end
  end

  count
end

def part2(input)
  # TODO
end

real_input = File.read('day07-input.txt')

puts "Part 1: #{part1(real_input)}"
puts "Part 2: #{part2(real_input)}"
