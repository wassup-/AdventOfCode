import Core
import Foundation

let input = try! Input(day: 4)

var passports: [Passport] = []
var passportLines: [String] = []
for line in input.lines {
    if line.isEmpty {
        passports.append(.init(lines: passportLines))
        passportLines.removeAll()
    } else {
        passportLines.append(line)
    }
}

print("number of passports: \(passports.count)")
print("number of valid passports: \(passports.filter(\.isValid).count)")
