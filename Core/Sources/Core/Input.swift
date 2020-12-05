import Foundation

public struct Input {
    public let contents: String

    public init(day: Int) throws {
        contents = try String(contentsOfFile: "./Inputs/Day \(day).txt")
    }
}

public extension Input {
    var lines: [String] {
        contents.components(separatedBy: .newlines)
    }
}
