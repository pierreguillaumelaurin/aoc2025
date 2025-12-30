#!/usr/bin/env ruby
# frozen_string_literal: true

def count_paths(source, destination, tree)
  return 1 if tree[source].include?(destination)

  tree[source].sum { count_paths(it, destination, tree) }
end

def dfs(source, destination, tree, visited = nil)
  visited ||= []
  return if visited.include?(source)
  return visited << destination if source == destination

  tree[source].each { dfs(it, destination, tree, visited) }

  visited << source
end

def part1(input)
  tree = input
         .lines
         .map(&:chomp)
         .map { it.split(': ') }
         .to_h { |node, neighbors| [node, neighbors.split] }

  count_paths('you', 'out', tree)
end

def run_path_counting(topological_order, tree, count_hash)
  topological_order.each do |node|
    tree[node]&.each do |child|
      count_hash[child] += count_hash[node]
    end
  end
end

def part2(input)
  tree = input
         .lines
         .map(&:chomp)
         .map { |line| line.split(': ') }
         .to_h { |node, neighbors| [node, neighbors.split] }

  topological_order = dfs('svr', 'out', tree).reverse
  all_nodes = tree.keys | tree.values.flatten

  # Segment 1: svr -> fft (which comes first in my input)
  count1 = all_nodes.to_h { |node| [node, node == 'svr' ? 1 : 0] }
  run_path_counting(topological_order, tree, count1)
  paths1 = count1['fft']

  # Segment 2: fft -> dag
  count2 = all_nodes.to_h { |node| [node, node == 'fft' ? 1 : 0] }
  run_path_counting(topological_order, tree, count2)
  paths2 = count2['dac']

  # Segment 3: dag -> out
  count3 = all_nodes.to_h { |node| [node, node == 'dac' ? 1 : 0] }
  run_path_counting(topological_order, tree, count3)
  paths3 = count3['out']

  paths1 * paths2 * paths3
end

real_input = File.read('day11-input.txt')

puts "Part 1: #{part1(real_input)}"
puts "Part 2: #{part2(real_input)}"
