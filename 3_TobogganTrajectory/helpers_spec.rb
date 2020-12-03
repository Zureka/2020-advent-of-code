require "minitest/autorun"
require_relative "helpers"

describe "Helper" do
  describe "retrieveNextSlopePoint" do
    it "returns empty string if rows list is empty" do
      rows = []
      assert_equal "", retrieveSlopePoint(rows, 1, 1)
    end

    it "returns the next slope points within row bounds" do
      rows = [
        %w[. . # # . . . . . . .],
        %w[# . . . # . . . # . .]
      ]
      assert_equal ".", retrieveSlopePoint(rows, 0, 0)
    end

    it "returns the slope points outside of row bounds" do
      rows = [
        %w[. . # # . . . . . . .],
        %w[# . . . # . . . # . .]
      ]
      assert_equal "#", retrieveSlopePoint(rows, 11, 1)
    end

    it "returns '#' for row 15 column 5" do
      rows = [
        ".##......#.##..#..#..##....#...".split(""),
        "...##.....#...###........###...".split(""),
        "#....##....#.....#.....#..##.##".split(""),
        ".......#.###.#......#..#..#..#.".split(""),
        "##..........#....#.#...#.......".split(""),
        "###.#.#.#......##...#..........".split(""),
        ".#.##........#..............#..".split(""),
        "..#..........#...##..#.......##".split(""),
        ".........##...#...#....###.#...".split(""),
        "#.......#.....#.#.#...###.##.#.".split(""),
        "...#...#...#......#........#.##".split(""),
        "....#..........#.....#..#....##".split("")
      ]

      assert_equal "#", retrieveSlopePoint(rows, 15, 5)
    end
  end

  describe "count_num_trees" do
    it "returns 7 for the example data" do
      rows = [
        "..##.......".split(""),
        "#...#...#..".split(""),
        ".#....#..#.".split(""),
        "..#.#...#.#".split(""),
        ".#...##..#.".split(""),
        "..#.##.....".split(""),
        ".#.#.#....#".split(""),
        ".#........#".split(""),
        "#.##...#...".split(""),
        "#...##....#".split(""),
        ".#..#...#.#".split("")
      ]

      r1_d1_count = count_num_trees(rows, 1, 1)
      r3_d1_count = count_num_trees(rows, 3, 1)
      r5_d1_count = count_num_trees(rows, 5, 1)
      r7_d1_count = count_num_trees(rows, 7, 1)
      r1_d2_count = count_num_trees(rows, 1, 2)

      assert_equal 2, r1_d1_count
      assert_equal 7, r3_d1_count
      assert_equal 3, r5_d1_count
      assert_equal 4, r7_d1_count
      assert_equal 2, r1_d2_count
      assert_equal 336, (r1_d1_count * r3_d1_count * r5_d1_count * r7_d1_count * r1_d2_count)
    end
  end
end
