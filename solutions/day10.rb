#!/usr/bin/env ruby
# frozen_string_literal: true

def parse_target(input)
  input[1...-1].split('').map { it == '#' ? 1 : 0 }
end

def parse_button(input)
  input[1...-1].split(',').map(&:to_i)
end

def parse_requirements(input)
  input[1...-1].split(',').map(&:to_i)
end

def bfs(target, buttons)
  queue = [[[0] * target.length, 0]]
  visited = Set.new

  until queue.empty?
    state, count = queue.shift
    next if visited.include?(state)

    visited.add(state)

    return count if target == state

    buttons.each do |button|
      next_state = state.dup
      button.each do |index|
        next_state[index] ^= 1
      end

      queue << [next_state, count + 1]
    end
  end
end

def part1(input)
  input
    .lines
    .map { it.split[...-1] }
    .map { |(target, *buttons)| [parse_target(target), buttons.map { parse_button(it) }] }
    .sum { |(target, buttons)| bfs(target, buttons) }
end

def part2(input)
  input
    .lines
    .map(&:split)
    .map do |(target, *buttons, intensity)|
    [parse_target(target), buttons.map do
      parse_button(it)
    end, parse_requirements(intensity)]
  end
end

real_input = File.read('day10-input.txt')

puts "Part 1: #{part1(real_input)}"
puts "Part 2: #{part2(real_input)}"
