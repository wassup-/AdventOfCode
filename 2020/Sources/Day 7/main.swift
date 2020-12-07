import Algorithms
import Core
import Foundation

let input = try! Input(day: 7)
let rules = input.lines.compactMap(Rule.init)

// Part 1

var cache: [String: Set<String>] = [:]
let part1 = rules
    .map { $0.extrapolated(usingRules: rules, cache: &cache) }
    .filter { $0.contents.contains("shiny gold") }
    .count

print("part 1: \(part1)")
