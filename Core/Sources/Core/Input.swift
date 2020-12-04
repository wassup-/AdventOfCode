import Foundation

public struct Input {
    public let contents: String

    public init(day: Int) throws {
        contents = try String(contentsOfFile: "./Inputs/\(day).txt")
    }
}

public extension Input {
    var lines: [String] {
        contents.components(separatedBy: .newlines)
    }
}
