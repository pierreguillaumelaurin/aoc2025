#!/usr/bin/env ruby
# frozen_string_literal: true

class DAG
  def initialize(grid)
    @grid = grid
    @transposed_grid = grid.transpose
    @graph = Hash.new { |hash, key| hash[key] = Set.new }

    starting_column = @grid[0].find_index { _1 == 'S' }
    build_graph([0, starting_column])
  end

  def nodes
    @graph.keys
  end

  private

  def build_graph(start, visited = Set.new)
    return if start.nil? || visited.include?(start)

    visited.add(start)

    neighbors = find_neighbors(start)

    @graph[start] += neighbors

    return nil if neighbors.empty?

    neighbors.each do |neighbor|
      build_graph(neighbor, visited)
    end
  end

  def find_neighbors((x, y))
    if @grid[x][y] == 'S'
      [find_next_tachyon([x, y])].compact
    else
      left_neighbor = find_next_tachyon([x, y - 1])
      right_neighbor = find_next_tachyon([x, y + 1])
      [left_neighbor, right_neighbor].compact
    end
  end

  def find_next_tachyon((x, y))
    return nil if x.negative? || x >= @grid.length

    next_tachyon_x = @transposed_grid[y].each_with_index.find_index { |element, index| element == '^' && index > x }

    [next_tachyon_x, y] if next_tachyon_x
  end
end

def part1(input)
  grid = input.lines.map(&:chomp).map { _1.split('') }
  dag = DAG.new(grid)

  dag.nodes.length - 1
end

def part2(input)
  # TODO
end

real_input = File.read('day07-input.txt')

puts "Part 1: #{part1(real_input)}"
# answer 1581
puts "Part 2: #{part2(real_input)}"
