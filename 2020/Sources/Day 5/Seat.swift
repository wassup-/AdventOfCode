import Core
import Foundation

enum Region: String.Element {
    case front = "F"
    case back = "B"
    case left = "L"
    case right = "R"
}

struct Seat {
    let row: Int
    let col: Int

    var id: Int {
        (row * 8) + col
    }

    init?(path: String) {
        let pattern: [Region] = path.compactMap(Region.init)
        self.init(pattern: pattern)
    }

    init?(pattern: [Region]) {
        guard pattern.count == 10 else { return nil }
        // precondition(pattern.count == 10, "wrong pattern count")

        row = {
            let mask = pattern.prefix(7).map(\.bit)
            return Int(bitPattern: Bitmask(mask: mask).bitPattern)
        }()

        col = {
            let mask = pattern.suffix(3).map(\.bit)
            return Int(bitPattern: Bitmask(mask: mask).bitPattern)
        }()
    }
}

extension Region {
    var bit: Bitmask.Bit {
        switch self {
        case .back, .right:
            return .one
        case .front, .left:
            return .zero
        }
    }
}
