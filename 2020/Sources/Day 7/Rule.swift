import Foundation

struct Rule {
    let color: String
    let contents: Set<String>
}

extension Rule {
    init?(_ text: String) {
        guard let range = text.range(of: "bags contain") else { return nil }

        color = String(text[..<text.index(before: range.lowerBound)])
        contents = Set(
            text[text.index(after: range.upperBound)...]
                .components(separatedBy: ", ")
                .compactMap(Self.extract_contents)
        )
    }

    private static func extract_contents(_ text: String) -> String? {
        guard let range = text.range(of: "bag") else { return nil }

        let contents = String(text[..<text.index(before: range.lowerBound)])
        guard let index = contents.firstIndex(of: " ") else { return contents }
        return String(contents[contents.index(after: index)...])
    }

    func extrapolated(usingRules rules: [Rule], cache: inout [String: Set<String>]) -> Rule {
        var extrapolated: Set<String> = Set(contents)
        defer { cache[color] = extrapolated }

        extrapolated = contents.reduce(into: extrapolated) { acc, content in
            if let cached = cache[content] {
                acc.formUnion(cached)
            } else if let rule = rules.first(where: { $0.color == content }) {
                acc.formUnion(rule.extrapolated(usingRules: rules, cache: &cache).contents)
            }
        }

        return Rule(color: color, contents: extrapolated)
    }
}
