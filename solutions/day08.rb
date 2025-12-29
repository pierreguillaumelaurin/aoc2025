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
  boxes = input.lines.map(&:chomp).map { _1.split(',').map(&:to_i) }
  edges = (0...boxes.length).to_a.combination(2).to_a
  edges.sort_by! do |(first_idx, second_idx)|
    hypothenuse(*boxes[first_idx].zip(boxes[second_idx]).map { |first, second| first - second })
  end

  parents = (0...boxes.length).to_a

  edges[...1000].each do |first, second|
    merge(first, second, parents)
  end

  sizes = [0] * boxes.length

  (0...boxes.length).each do |i|
    sizes[root(i, parents)] += 1
  end

  sizes.sort.reverse.take(3).reduce(1) { |n, product| n * product }
end

def part2(input)
  boxes = input.lines.map(&:chomp).map { _1.split(',').map(&:to_i) }
  edges = (0...boxes.length).to_a.combination(2).to_a
  edges.sort_by! do |(first_idx, second_idx)|
    hypothenuse(*boxes[first_idx].zip(boxes[second_idx]).map { |first, second| first - second })
  end

  parents = (0...boxes.length).to_a

  circuits = boxes.length

  edges.each do |first, second|
    next if root(first, parents) == root(second, parents)

    merge(first, second, parents)
    circuits -= 1

    break boxes[first].first * boxes[second].first if circuits == 1
  end
end

real_input = File.read('day08-input.txt')

puts "Part 1: #{part1(real_input)}"
puts "Part 2: #{part2(real_input)}"
