require 'fileutils'
require 'net/http'
require 'uri'
require 'dotenv'

Dotenv.load

namespace :aoc do
  desc 'Create a new solution file for a given day'
  task :new, [:day] do |_t, args|
    day = args[:day].to_i
    year = 2025

    raise 'Day must be provided' if day.zero?
    raise 'Day must be between 1 and 25' unless (1..25).include?(day)

    day_str = day.to_s.rjust(2, '0')
    solution_filename = "solutions/day#{day_str}.rb"
    input_filename = "solutions/day#{day_str}-input.txt"

    # Create solution file from template
    if File.exist?('template.rb')
      template = File.read('template.rb')
      solution_content = template.gsub('{DAY}', day_str)
      File.write(solution_filename, solution_content)
      puts "Created #{solution_filename}"
    else
      raise 'template.rb not found'
    end

    # Fetch input
    session_token = ENV['AOC_SESSION_TOKEN']
    if session_token.nil? || session_token.empty?
      puts 'AOC_SESSION_TOKEN not set in .env file. Creating empty input file.'
      FileUtils.touch(input_filename)
      next
    end

    uri = URI("https://adventofcode.com/#{year}/day/#{day}/input")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    request['Cookie'] = "session=#{session_token}"

    response = http.request(request)

    if response.code == '200'
      File.write(input_filename, response.body)
      puts "Fetched and saved input to #{input_filename}"
    else
      puts "Failed to fetch input: #{response.code} #{response.message}"
      puts "Creating empty input file."
      FileUtils.touch(input_filename)
    end
  end
end
