import Algorithms
import Core
import Foundation

let input = try! Input(day: 6)
let groups = input.lines.chunked(by: { _, rhs in !rhs.isEmpty })

// Part 1

let part1 = groups
    .map { Set($0.joined()).count }
    .reduce(0, +)
print("part1: \(part1)")

// Part 2

let part2 = groups
    .map { $0.filter { !$0.isEmpty } }
    .map { group in
        guard let first = group.first else { return 0 }

        var votes = Set(first)

        for row in group.dropFirst() {
            votes.formIntersection(row)
        }

        return votes.count
    }
    .reduce(0, +)

print("part2: \(part2)")
