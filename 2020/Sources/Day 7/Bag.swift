import Foundation

struct Bag {
    struct Content {
        let color: String
        let amount: Int
    }

    let color: String
    let contents: [Content]
}

extension Bag {
    init?(_ text: String) {
        guard let range = text.range(of: "bags contain") else { return nil }

        color = String(text[..<text.index(before: range.lowerBound)])
        contents = text[text.index(after: range.upperBound)...]
            .components(separatedBy: ", ")
            .compactMap(Self.extract_contents)
    }

    private static func extract_contents(_ text: String) -> Content? {
        guard let range = text.range(of: "bag") else { return nil }

        let contents = String(text[..<text.index(before: range.lowerBound)])
        guard let index = contents.firstIndex(of: " "),
              let amount = Int(contents[..<index]) else { return nil }

        return Content(
            color: String(contents[contents.index(after: index)...]),
            amount: amount
        )
    }

    func extrapolated(usingBags bags: [Bag], cache: inout [String: [Content]]) -> Bag {
        var extrapolated: [Content] = contents
        defer { cache[color] = extrapolated }

        extrapolated = contents.reduce(extrapolated) { acc, content in
            if let cached = cache[content.color] {
                return acc + cached
            } else if let rule = bags.first(where: { $0.color == content.color }) {
                return acc + rule.extrapolated(usingBags: bags, cache: &cache).contents
            } else {
                return acc
            }
        }

        return Bag(
            color: color,
            contents: extrapolated
        )
    }
}
