#!/usr/bin/env ruby
# frozen_string_literal: true

def area(p1, p2)
  (p1[0] - p2[0]).abs.succ * (p1[1] - p2[1]).abs.succ
end

def part1(input)
  pts = input.scan(/-?\d+/).map(&:to_i).each_slice(2).to_a
  pts.combination(2).map { |pair| area(pair[0], pair[1]) }.max
end

def compressed_coordinates(vertices)
  xs = vertices.map(&:first).uniq.sort
  ys = vertices.map(&:last).uniq.sort
  xm = xs.each_with_index.to_h
  ym = ys.each_with_index.to_h
  vertices.map { |pt| [xm[pt[0]], ym[pt[1]]] }
end

def vertical_edges(cpts)
  (cpts + [cpts[0]]).each_cons(2)
                    .select { |edge| edge[0][0] == edge[1][0] }
                    .map { |edge| [edge[0][0], Range.new(*[edge[0][1], edge[1][1]].sort, true)] }
end

def interior_cells(edges, x_size, y_size)
  (0...y_size - 1).map do |j|
    axs = edges.select { |edge| edge[1].cover?(j) }.map(&:first).sort
    (0...x_size - 1).map { |i| axs.count { |x| x <= i }.odd? }
  end
end

def area_table(grid, x_size, y_size)
  sat = Array.new(y_size + 1) { Array.new(x_size + 1, 0) }
  grid.each_with_index do |row, j|
    s = 0
    row.each_with_index { |v, i| sat[j + 1][i + 1] = sat[j][i + 1] + (s += (v ? 1 : 0)) }
  end
  sat
end

def find_max_valid_area(vertices, area_table, map_x, map_y)
  vertices.combination(2).map do |pair|
    p1 = pair[0]
    p2 = pair[1]
    x1 = [p1[0], p2[0]].min
    x2 = [p1[0], p2[0]].max
    y1 = [p1[1], p2[1]].min
    y2 = [p1[1], p2[1]].max

    next 0 if x1 == x2 || y1 == y2

    count = area_table[y2][x2] - area_table[y1][x2] - area_table[y2][x1] + area_table[y1][x1]
    count == (x2 - x1) * (y2 - y1) ? area([map_x[p1[0]], map_y[p1[1]]], [map_x[p2[0]], map_y[p2[1]]]) : 0
  end.max
end

def flood_fill(vertices, map_x, map_y)
  edges = vertical_edges(vertices)
  grid = interior_cells(edges, map_x.size, map_y.size)
  areas = area_table(grid, map_x.size, map_y.size)
  find_max_valid_area(vertices, areas, map_x, map_y)
end

def part2(input)
  tiles = input.scan(/-?\d+/).map(&:to_i).each_slice(2).to_a

  map_x = tiles.map(&:first).uniq.sort
  map_y = tiles.map(&:last).uniq.sort

  flood_fill(compressed_coordinates(tiles), map_x, map_y)
end

real_input = File.read('day09-input.txt')
puts "Part 1: #{part1(real_input)}", "Part 2: #{part2(real_input)}"
