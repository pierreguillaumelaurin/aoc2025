# Advent of Code 2025 Ruby Solutions

In contrast to [last year's approach](https://github.com/pierreguillaumelaurin/aoc2024) of building solutions with custom classes and utilities, this year I'm creating self-contained solutions, inspired by [gchan](https://github.com/gchan/advent-of-code-ruby)'s 2024 Ruby solutions.

## Usage
To reuse the templates for your own solutions

1.  **Setup**:
    ```bash
    bundle install
    ```
2.  **Authentication**: Create a `.env` file in the root of the project and add your Advent of Code session token:
    ```
    AOC_SESSION_TOKEN=your_session_token_here
    ```
3.  **Scaffold a new day**: Use the `rake` task to create the solution file and download the input:
    ```bash
    rake aoc:new[1] # For day 1
    ```
