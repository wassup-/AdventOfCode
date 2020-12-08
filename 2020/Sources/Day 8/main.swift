import Core
import Foundation

struct Instruction {
    enum Operation: String {
        case acc, jmp, nop
    }

    var operation: Operation
    let constant: Int

    init?(_ text: String) {
        let parts = text.split(separator: " ", maxSplits: 2)
        guard parts.count == 2,
              let operation = Operation(rawValue: String(parts[0])),
              let constant = Int(parts[1]) else { return nil }

        self.operation = operation
        self.constant = constant
    }
}

struct Program {
    var instructions: [Instruction]

    init(input: Input) {
        instructions = input.lines.compactMap(Instruction.init)
    }

    func execute() -> (finished: Bool, acc: Int) {
        var index = instructions.startIndex
        var executed: Set<Array<Instruction>.Index> = []

        var acc = 0
        while index != instructions.endIndex {
            guard executed.insert(index).inserted else { return (false, acc) }

            let instruction = instructions[index]
            switch instruction.operation {
            case .nop:
                index = instructions.index(after: index)
            case .jmp:
                index = instructions.index(index, offsetBy: instruction.constant)
            case .acc:
                acc += instruction.constant
                index = instructions.index(after: index)
            }
        }

        return (true, acc)
    }
}

let input = try! Input(day: 8)

// Part 1

let program = Program(input: input)
let (_, acc) = program.execute()
print("part 1: \(acc)")

// Part 2

for index in program.instructions.indices {
    var copy = program
    switch copy.instructions[index].operation {
    case .nop:
        copy.instructions[index].operation = .jmp
    case .jmp:
        copy.instructions[index].operation = .nop
    default:
        continue
    }

    let (finished, acc) = copy.execute()
    if finished {
        print("part 2: \(acc)")
        break
    }
}
