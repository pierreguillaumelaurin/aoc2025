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
  columns = input
            .lines
            .map(&:chomp)
            .map { _1.split('') }
            .transpose

  numbers = columns.each_with_object([]) do |group, arr|
    if arr.empty?
      arr << [group[...-1].join.to_i]
    elsif group.all? { _1 == "\s" }
      arr << []
    else
      arr[-1] << group[...-1].join.to_i
    end
  end

  operators = input.lines.map(&:chomp)[-1].split('').reject { _1 == "\s" }

  operations = numbers.zip(operators).map do |(numbers, operator)|
    if operator == '+'
      numbers.sum
    else
      numbers.reduce(1) do |n, product|
        product * n
      end
    end
  end

  operations.sum
end

real_input = File.read('day06-input.txt')

example = File.read('day06-example.txt')

puts "Part 1: #{part1(real_input)}"
# answer 3261038365331
puts "Part 2: #{part2(real_input)}"
# 8342525158298 too low
# answer 8342588849093
