#!/usr/bin/env ruby
# frozen_string_literal: true

def to_grid(input)
  input
    .lines
    .map(&:chomp)
    .map { _1.split('') }
end

def part1(input)
  grid = to_grid(input)
  count = 0

  grid.each_with_index do |_, i|
    grid[i].each_with_index do |_cell, j|
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

      count += 1 if grid[i][j] == '@' && adjacents.select { _1 == '@' }.length < 4
    end
  end

  count
end

def part2(input)
  # TODO
end

real_input = File.read('day04-input.txt')

puts "Part 1: #{part1(real_input)}"
# 16020 too high
# 2264 too high
puts "Part 2: #{part2(real_input)}"
