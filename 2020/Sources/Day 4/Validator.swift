import Foundation

struct Validator {
    let validate: (String) -> Bool
}

extension Validator {
    static func number(min: Int? = nil, max: Int? = nil) -> Validator {
        Validator { input in
            guard let number = Int(input) else { return false }
            if let min = min, number < min { return false }
            if let max = max, number > max { return false }
            return true
        }
    }

    static var height: Validator {
        Validator { input in
            guard input.count > 2 else { return false }

            let unit = input.suffix(2)
            let value = String(input.dropLast(2))

            switch unit {
            case "cm":
                return number(min: 150, max: 193).validate(value)
            case "in":
                return number(min: 59, max: 76).validate(value)
            default:
                return false
            }
        }
    }

    static var color: Validator {
        Validator { input in
            ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(input)
        }
    }

    static var hex: Validator {
        Validator { input in
            guard input.hasPrefix("#"), input.count == 7 else { return false }
            let startIndex = input.index(after: input.startIndex)
            return Int(input.suffix(from: startIndex), radix: 16) != nil
        }
    }

    static var passportID: Validator {
        Validator { input in
            input.count == 9 && number().validate(input)
        }
    }
}
