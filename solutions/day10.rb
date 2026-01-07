#!/usr/bin/env ruby
# frozen_string_literal: true

def parse_button(input)
  input[1...-1].split(',').map(&:to_i)
end

# --- Part 1 ---

def parse_target(input)
  input[1...-1].split('').map { |c| c == '#' ? 1 : 0 }
end

def bfs(target, buttons)
  queue = [[[0] * target.length, 0]]
  visited = Set[queue[0][0]]

  until queue.empty?
    state, count = queue.shift
    return count if target == state

    buttons.each do |button|
      next_state = state.dup
      button.each { |index| next_state[index] ^= 1 }

      next if visited.include?(next_state)

      visited.add(next_state)
      queue << [next_state, count + 1]
    end
  end
  Float::INFINITY
end

def part1(input)
  input.lines.sum do |line|
    target_str, *buttons_str = line.split[...-1]
    next 0 unless target_str

    target = parse_target(target_str)
    buttons = buttons_str.map { |b| parse_button(b) }
    bfs(target, buttons)
  end
end

# --- Part 2 ---

def parse_requirements(input)
  input[1...-1].split(',').map(&:to_i)
end

def patterns(coeffs)
  num_buttons = coeffs.length
  return {} if num_buttons.zero?

  num_variables = coeffs[0].length
  out = Hash.new { |h, k| h[k] = {} }

  (0..num_buttons).each do |num_pressed|
    (0...num_buttons).to_a.combination(num_pressed).each do |indices|
      vectors = indices.map { |i| coeffs[i] }
      pattern = vectors.empty? ? [0] * num_variables : vectors.transpose.map(&:sum)

      parity = pattern.map { |x| x % 2 }
      out[parity][pattern] ||= num_pressed
    end
  end
  out
end

def solve_single(goal, pattern_costs)
  memo = {}
  solve_aux = lambda do |current_goal|
    return 0 if current_goal.all?(&:zero?)
    return memo[current_goal] if memo.key?(current_goal)

    goal_parity = current_goal.map { |i| i % 2 }

    possible_costs = (pattern_costs[goal_parity] || {}).filter_map do |pattern, cost|
      next unless pattern.zip(current_goal).all? { |p, g| p <= g }

      new_goal = pattern.zip(current_goal).map { |p, g| (g - p) / 2 }
      res = solve_aux.call(new_goal)

      cost + 2 * res if res != Float::INFINITY
    end

    memo[current_goal] = possible_costs.min || Float::INFINITY
  end

  solve_aux.call(goal)
end

def part2(input)
  input.lines.sum do |line|
    _target, *buttons, intensity = line.split
    next 0 if intensity.nil?

    goal = parse_requirements(intensity)
    num_counters = goal.length
    next 0 if num_counters.zero?

    parsed_buttons = buttons.map { |b| parse_button(b) }
    coeffs = parsed_buttons.map do |indices|
      Array.new(num_counters) { |i| indices.include?(i) ? 1 : 0 }
    end

    pattern_costs = patterns(coeffs)
    solve_single(goal, pattern_costs)
  end
end

# --- Main execution ---

real_input = File.read('day10-input.txt')

puts "Part 1: #{part1(real_input)}"
puts "Part 2: #{part2(real_input)}"
