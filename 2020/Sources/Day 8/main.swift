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

    @discardableResult
    func execute(acc: inout Int) -> Bool {
        var index = instructions.startIndex
        var executed: Set<Array<Instruction>.Index> = []

        while index != instructions.endIndex {
            guard executed.insert(index).inserted else { return false }

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

        return true
    }
}

let input = try! Input(day: 8)

// Part 1

let program = Program(input: input)
var acc = 0
program.execute(acc: &acc)
print("part 1: \(acc)")

// Part 2

let jumps = program.instructions.enumerated()
    .filter { $1.operation == .jmp }
    .map { idx, _ in idx }

for index in jumps {
    var copy = program
    copy.instructions[index].operation = .nop

    var acc = 0
    if copy.execute(acc: &acc) {
        print("part 2: \(acc)")
        break
    }
}

let nops = program.instructions.enumerated()
    .filter { $1.operation == .nop }
    .map { idx, _ in idx }

for index in nops {
    var copy = program
    copy.instructions[index].operation = .jmp

    var acc = 0
    if copy.execute(acc: &acc) {
        print("part 2: \(acc)")
        break
    }
}
