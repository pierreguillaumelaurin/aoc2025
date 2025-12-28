#!/usr/bin/env ruby
# frozen_string_literal: true

def hypothenuse(x, y, z)
  Math.sqrt([x, y, z].sum { |coord| coord**2 })
end

def root(node, parents)
  return node if parents[node] == node

  root(parents[node], parents)
end

def merge(a, b, parents)
  parents[root(a, parents)] = root(b, parents)
end

def part1(input)
  # A thousand times we need to
  # 1. find the 2 junction boxes that are the closest together
  # 2. check if one (or both) are part of a network
  # 3. connect the networks together
  # Then, we multiply the 3 largest circuits
  boxes = input.lines.map(&:chomp).map { _1.split(',').map(&:to_i) }
  edges = boxes.each_with_index.each_slice(2).map { |(_, first_i), (__, second_i)| [first_i, second_i] }
  edges.sort_by! do |(first_idx, second_idx)|
    hypothenuse(*boxes[first_idx].zip(boxes[second_idx]).map { |first, second| first - second })
  end

  parents = (0...boxes.length).to_a

  sizes = [0] * boxes.length

  boxes.each do |box|
    sizes
  end
  ##  networks
  #    .sort { |a, b| a.count <=> b.count }
  #    .reverse
  #    .take(3)
  #    .reduce(1) { |network, product| product * network }
end

def part2(input)
  # TODO
end

real_input = File.read('day08-input.txt')

puts "Part 1: #{part1(real_input)}"
puts "Part 2: #{part2(real_input)}"
