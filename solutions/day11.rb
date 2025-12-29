#!/usr/bin/env ruby
# frozen_string_literal: true

def count_paths(source, destination, tree)
  return 1 if tree[source].include?(destination)

  tree[source].sum { count_paths(it, destination, tree) }
end

def part1(input)
  tree = input
         .lines
         .map(&:chomp)
         .map { it.split(': ') }
         .to_h { |node, neighbors| [node, neighbors.split("\s")] }

  count_paths('you', 'out', tree)
end

def part2(input)
  # TODO
end

real_input = File.read('day11-input.txt')

puts "Part 1: #{part1(real_input)}"
puts "Part 2: #{part2(real_input)}"
