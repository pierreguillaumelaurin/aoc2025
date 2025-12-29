#!/usr/bin/env ruby
# frozen_string_literal: true

def count_paths(source, destination, tree)
  return 1 if tree[source].include?(destination)

  tree[source].sum { count_paths(it, destination, tree) }
end

def count_selected_paths(source, destination, tree, visited = Set.new)
  return 0 if visited.include?(source)

  path_so_far = visited.union([source])

  if tree[source].include?(destination)
    return 1 if path_so_far.include?('dac') && path_so_far.include?('fft')

    return 0
  end

  tree[source].sum { count_selected_paths(it, destination, tree, path_so_far) }
end

def part1(input)
  tree = input
         .lines
         .map(&:chomp)
         .map { it.split(': ') }
         .to_h { |node, neighbors| [node, neighbors.split] }

  count_paths('you', 'out', tree)
end

def part2(input)
  tree = input
         .lines
         .map(&:chomp)
         .map { it.split(': ') }
         .to_h { |node, neighbors| [node, neighbors.split] }

  count_selected_paths('svr', 'out', tree)
end

real_input = File.read('day11-input.txt')

puts "Part 1: #{part1(real_input)}"
puts "Part 2: #{part2(real_input)}"
