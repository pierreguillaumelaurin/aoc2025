#!/usr/bin/env ruby
# frozen_string_literal: true

def invalid?(id)
  return false if id.length.odd?

  middle_index = id.length / 2
  id[0...middle_index] == id[middle_index..id.length]
end

def invalid_invalid?(id)
  dup = id + id
  dup[1...dup.length - 1].include?(id)
end

def part1(input)
  input
    .split(',')
    .map { _1.split('-').map(&:to_i) }
    .sum do |floor, ceil|
      (floor..ceil).select { invalid?(_1.to_s) }.sum
    end
end

def part2(input)
  input
    .split(',')
    .map { _1.split('-').map(&:to_i) }
    .sum do |floor, ceil|
      (floor..ceil).select { invalid_invalid?(_1.to_s) }.sum
    end
end

real_input = File.read('day02-input.txt')

puts "Part 1: #{part1(real_input)}"
puts "Part 2: #{part2(real_input)}"
