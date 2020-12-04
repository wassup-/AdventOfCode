import Foundation

struct Policy {
    let indices: [Int]
    let character: String
}

extension Policy {
    init?(policy: String, character: String) {
        indices = policy.components(separatedBy: "-").compactMap(Int.init)
        self.character = character.last == ":" ? String(character.dropLast()) : character
    }

    func validate(_ password: String) -> Bool {
        indices
            .map { password.index(password.startIndex, offsetBy: $0 - 1) }
            .map { password[$0] }
            .filter { String($0) == character }
            .count == 1
    }
}
