import Core
import Foundation

struct Grid {
    private let grid: [String]
    let height: Int

    init(_ input: Input) throws {
        grid = input.lines.filter { !$0.isEmpty }
        height = grid.count
    }

    func check(x: Int, y: Int) -> Bool {
        let row = grid[y % height]
        let character = row[row.index(row.startIndex, offsetBy: x % row.count)]
        return character == "#"
    }
}
