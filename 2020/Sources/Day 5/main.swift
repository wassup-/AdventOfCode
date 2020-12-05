import Core
import Foundation

let test = Seat(path: "FBFBBFFRLR")!
precondition(test.row == 44, "wrong row \(test.row)")
precondition(test.col == 5, "wrong col \(test.col)")
precondition(test.id == 357, "wrong id \(test.id)")

let input = try! Input(day: 5)

// Part 1

var highestSeatId: Int = 0
for line in input.lines {
    guard let seat = Seat(path: line) else { continue }
    highestSeatId = max(highestSeatId, seat.id)
}

print("highest seat id: \(highestSeatId)")

// Part 2

let seats = input.lines
    .compactMap(Seat.init)
    .map(\.id)

let missing = (seats.first! ..< seats.last!)
    .first { !seats.contains($0) }!

print("your seat id: \(missing)")
