#!/usr/bin/env ruby
# frozen_string_literal: true

def part1(input)
  count = 0
  dial_position = 50

  input.lines
       .map(&:chomp)
       .map { |line| [line[0], line[1...line.length]] }
       .map { |(direction, *rest)| [(direction == 'L' ? '-' : '+'), rest.join.to_i, direction] }
       .each do |operator, n|
    dial_position = dial_position.send(operator, n)
    count += 1 if (dial_position % 100).zero?
  end

  count
end

def part2(input)
  count = 0
  dial_position = 50

  input.lines
       .map(&:chomp)
       .map { |line| [line[0], line[1...line.length]] }
       .map { |(direction, *rest)| [(direction == 'L' ? '-' : '+'), rest.join.to_i, direction] }
       .each do |operator, n|
    n.times do
      dial_position = dial_position.send(operator, 1)
      count += 1 if (dial_position % 100).zero?
    end
  end

  count
end

real_input = File.read('day01-input.txt')

puts "Part 1: #{part1(real_input)}"
puts "Part 2: #{part2(real_input)}"
