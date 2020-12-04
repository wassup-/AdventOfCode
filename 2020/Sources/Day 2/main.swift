import Core
import Foundation

let lines = try! Input(day: 2).lines

let validPasswordCount = lines.lazy.filter(is_valid_password).count
print("number of passwords: \(lines.count)")
print("number of valid passwords: \(validPasswordCount)")

func is_valid_password(_ line: String) -> Bool {
    // [0] = policy [1] = character [2] = password
    let parts = line.components(separatedBy: " ")
    guard parts.count == 3 else { return false }

    let policy = Policy(policy: parts[0], character: parts[1])
    return policy?.validate(parts[2]) ?? false
}
