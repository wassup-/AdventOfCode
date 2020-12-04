import Core
import Foundation

let input = try! Input(day: 3)

struct Move {
    let x: Int
    let y: Int
}

let moves: [Move] = [
    .init(x: 1, y: 1),
    .init(x: 3, y: 1),
    .init(x: 5, y: 1),
    .init(x: 7, y: 1),
    .init(x: 1, y: 2),
]

let grid = try! Grid(input)

let trees: [Int] = moves.map { move in
    var trees = 0

    var (x, y) = (0, 0)
    while y < grid.height {
        x += move.x
        y += move.y

        if grid.check(x: x, y: y) {
            trees += 1
        }
    }

    return trees
}

print(trees.reduce(1, *))
