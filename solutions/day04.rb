#!/usr/bin/env ruby
# frozen_string_literal: true

def to_grid(input)
  input
    .lines
    .map(&:chomp)
    .map { _1.split('') }
end

def for_each_removable_roll(grid)
  count = 0
  (0...grid.length).each do |i|
    (0...grid[i].length).each do |j|
      adjacents_row_indexes = (i - 1..i + 1).select { _1 >= 0 && _1 < grid.length }
      adjacents_cell_indexes = (j - 1..j + 1).select { _1 >= 0 && _1 < grid[i].length }
      adjacents = []
      adjacents_row_indexes.each do |row_i|
        row = []
        adjacents_cell_indexes.each do |cell_i|
          row[cell_i] = grid[row_i][cell_i] unless row_i == i && cell_i == j
        end
        adjacents += row
      end

      yield i, j if grid[i][j] == '@' && adjacents.select { _1 == '@' }.length < 4
    end
  end

  count
end

def part1(input)
  grid = to_grid(input)

  count = 0
  for_each_removable_roll(grid) { count += 1 }

  count
end

def part2(input)
  grid = to_grid(input)

  count = 0

  loop do
    iteration_count = 0

    for_each_removable_roll(grid) do |i, j|
      iteration_count += 1
      grid[i][j] = '.'
    end
    return count if iteration_count.zero?

    count += iteration_count
  end
end

real_input = File.read('day04-input.txt')

puts "Part 1: #{part1(real_input)}"
# 16020 too high
# 2264 too high
# answer 1495
puts "Part 2: #{part2(real_input)}"
# 4908 too low
# answer 8768
