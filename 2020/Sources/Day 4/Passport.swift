import Foundation

struct Passport {
    var byr: String = ""
    var iyr: String = ""
    var eyr: String = ""
    var hgt: String = ""
    var hcl: String = ""
    var ecl: String = ""
    var pid: String = ""
    var cid: String = ""

    init(lines: [String]) {
        let components = lines.flatMap { $0.components(separatedBy: .whitespaces) }
        for component in components {
            let parts = component.split(separator: ":", maxSplits: 2)
            guard parts.count == 2 else { continue }

            switch parts[0] {
            case "byr": byr = String(parts[1])
            case "iyr": iyr = String(parts[1])
            case "eyr": eyr = String(parts[1])
            case "hgt": hgt = String(parts[1])
            case "hcl": hcl = String(parts[1])
            case "ecl": ecl = String(parts[1])
            case "pid": pid = String(parts[1])
            case "cid": cid = String(parts[1])
            default: break
            }
        }
    }

    var isValid: Bool {
        Validator.number(min: 1920, max: 2002).validate(byr)
            && Validator.number(min: 2010, max: 2020).validate(iyr)
            && Validator.number(min: 2020, max: 2030).validate(eyr)
            && Validator.height.validate(hgt)
            && Validator.hex.validate(hcl)
            && Validator.color.validate(ecl)
            && Validator.passportID.validate(pid)
    }
}
