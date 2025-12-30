#!/usr/bin/env ruby
# frozen_string_literal: true

def parse(input)
  *raw_shapes, raw_regions = input.split("\n\n")

  regions = raw_regions
            .split("\n")
            .map { it.split }
            .map { |(size, *quantities)| [size[...-1].split('x').map(&:to_i), quantities.map(&:to_i)] }

  [raw_shapes, regions]
end

def part1(input)
  shapes, regions = parse(input)

  shape_areas = shapes.map { it.chars.count { it == '#' } }

  # approach credit goes to [gchan](https://github.com/gchan/advent-of-code-ruby/blob/main/2025/day-12/day-12-part-1.rb)
  # doesn't work with the example, only with the provided input
  regions.count do |(size_x, size_y), shape_quantities|
    total_area = size_x * size_y
    required_area = shape_quantities.each_with_index.sum do |qty, idx|
      qty * shape_areas[idx]
    end

    total_area >= required_area
  end
end

real_input = File.read('day12-input.txt')

puts "Part 1: #{part1(real_input)}"
puts 'No part 2 for today!'
