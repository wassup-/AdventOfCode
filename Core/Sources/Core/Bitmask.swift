public struct Bitmask {
    public enum Bit: Int {
        case zero = 0, one = 1
    }

    public let mask: [Bit]

    public init(pattern: [Int]) {
        let mask: [Bit] = pattern.compactMap(Bit.init)
        self.init(mask: mask)
    }

    public init(mask: [Bit]) {
        self.mask = mask
    }
}

public extension Bitmask {
    var bitPattern: UInt {
        let binary = mask
            .map { String($0.rawValue) }
            .joined()
        return UInt(binary, radix: 2)!
    }
}
